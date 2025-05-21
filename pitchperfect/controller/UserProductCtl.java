package pitchperfect.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import pitchperfect.bean.BaseBean;
import pitchperfect.bean.ProductBean;
import pitchperfect.exception.ApplicationException;
import pitchperfect.model.ProductModel;
import pitchperfect.util.DataUtility;
import pitchperfect.util.PropertyReader;
import pitchperfect.util.ServletUtility;

@WebServlet(name = "UserProductCtl", urlPatterns = { "/prodShelf" })
public class UserProductCtl extends BaseCtl {
	private static final long serialVersionUID = 1L;
	private static Logger log = Logger.getLogger(UserProductCtl.class);

	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		log.debug("UserProductCtl populateBean method start");
		ProductBean bean = new ProductBean();
		bean.setName(DataUtility.getString(request.getParameter("name")));
		log.debug("UserProductCtl populateBean method end");
		return bean;
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("UserProductCtl doGet method start");

		List list = null;
		int pageNo = 1;

		int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));
		if (pageSize <= 0) {
			pageSize = 10; // Default fallback
			log.warn("Invalid page size from property file, using default: 10");
		}

		String cidParam = request.getParameter("cId");
		long cID = 0;
		if (cidParam != null && DataUtility.isLong(cidParam)) {
			cID = DataUtility.getLong(cidParam);
		} else {
			log.debug("Invalid or missing category ID parameter: " + cidParam);
		}
		log.debug("Parsed cID: " + cID);

		ProductModel model = new ProductModel();
		ProductBean bean = (ProductBean) populateBean(request);

		try {
			if (cID > 0) {
				bean.setCategoryId(cID);
			}

			list = model.search(bean, pageNo, pageSize);

			if (list == null || list.size() == 0) {
				ServletUtility.setErrorMessage("No Record Found", request);
			}

			ServletUtility.setList(list, request);
			request.setAttribute("size", model.search(bean).size());
			ServletUtility.setPageNo(pageNo, request);
			ServletUtility.setPageSize(pageSize, request);
			ServletUtility.forward(getView(), request, response);

		} catch (ApplicationException e) {
			log.error("ApplicationException in doGet", e);
			ServletUtility.handleException(e, request, response);
			return;
		}
		log.debug("UserProductCtl doGet method end");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("UserProductCtl doPost method start");

		List list = null;
		int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
		int pageSize = DataUtility.getInt(request.getParameter("pageSize"));

		pageNo = (pageNo == 0) ? 1 : pageNo;
		pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader.getValue("page.size")) : pageSize;
		if (pageSize <= 0) {
			pageSize = 10;
			log.warn("Invalid page size, defaulting to 10");
		}

		ProductBean bean = (ProductBean) populateBean(request);
		ProductModel model = new ProductModel();
		String[] ids = request.getParameterValues("ids");
		String op = DataUtility.getString(request.getParameter("operation"));

		log.debug("Operation: " + op);
		log.debug("PageNo: " + pageNo + ", PageSize: " + pageSize);

		if (OP_SEARCH.equalsIgnoreCase(op) || OP_NEXT.equalsIgnoreCase(op) || OP_PREVIOUS.equalsIgnoreCase(op)) {
			if (OP_SEARCH.equalsIgnoreCase(op)) {
				pageNo = 1;
			} else if (OP_NEXT.equalsIgnoreCase(op)) {
				pageNo++;
			} else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
				pageNo--;
			}
		} else if (OP_NEW.equalsIgnoreCase(op)) {
			ServletUtility.redirect(SOTGView.PRODUCT_CTL, request, response);
			return;
		} else if (OP_DELETE.equalsIgnoreCase(op)) {
			pageNo = 1;
			if (ids != null && ids.length > 0) {
				ProductBean deleteBean = new ProductBean();
				for (String id : ids) {
					deleteBean.setId(DataUtility.getInt(id));
					try {
						model.delete(deleteBean);
					} catch (ApplicationException e) {
						log.error("Error deleting product ID: " + id, e);
						ServletUtility.handleException(e, request, response);
						return;
					}
				}
				ServletUtility.setSuccessMessage("Data Deleted Successfully", request);
			} else {
				ServletUtility.setErrorMessage("Select at least one record", request);
			}
		} else if (OP_RESET.equalsIgnoreCase(op)) {
			ServletUtility.redirect(SOTGView.PRODUCT_LIST_CTL, request, response);
			return;
		}

		try {
			list = model.search(bean, pageNo, pageSize);
			if (list == null || list.size() == 0) {
				ServletUtility.setErrorMessage("No Record Found", request);
			}
			ServletUtility.setList(list, request);
			request.setAttribute("size", model.search(bean).size());
			ServletUtility.setPageNo(pageNo, request);
			ServletUtility.setPageSize(pageSize, request);
			ServletUtility.forward(getView(), request, response);
		} catch (ApplicationException e) {
			log.error("ApplicationException in doPost", e);
			ServletUtility.handleException(e, request, response);
			return;
		}

		log.debug("UserProductCtl doPost method end");
	}

	@Override
	protected String getView() {
		return SOTGView.USER_PRODUCT_LIST_VIEW;
	}
}

