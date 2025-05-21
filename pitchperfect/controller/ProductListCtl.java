package pitchperfect.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
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

/**
 * Servlet implementation class ProductListCtl
 */
@WebServlet(name = "ProductListCtl", urlPatterns = { "/ctl/adminPortal/prod/prodList" })
public class ProductListCtl extends BaseCtl {
	private static final long serialVersionUID = 1L;

	private static Logger log = Logger.getLogger(ProductListCtl.class);

	@Override
	protected BaseBean populateBean(HttpServletRequest request) {
		log.debug("ProductListCtl populateBean method start");

		ProductBean bean = new ProductBean();
		bean.setName(DataUtility.getString(request.getParameter("name")));
		
		// Added: Category ID from URL parameter
		long categoryId = DataUtility.getLong(request.getParameter("cId"));
		if (categoryId > 0) {
			bean.setCategoryId(categoryId);
		}

		log.debug("ProductListCtl populateBean method end");
		return bean;
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("ProductListCtl doGet method start");

		List<ProductBean> list = null;
		int pageNo = 1;
		int pageSize = DataUtility.getInt(PropertyReader.getValue("page.size"));

		ProductModel model = new ProductModel();
		ProductBean bean = (ProductBean) populateBean(request);

		long prId = DataUtility.getLong(request.getParameter("prdId"));
		try {
			if (prId > 0) {
				ProductBean deleteBean = new ProductBean();
				deleteBean.setId(prId);
				model.delete(deleteBean);
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
			log.error("Exception in ProductListCtl doGet", e);
			ServletUtility.handleException(e, request, response);
		}

		log.debug("ProductListCtl doGet method end");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		log.debug("ProductListCtl doPost method start");

		List<ProductBean> list = null;
		int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
		int pageSize = DataUtility.getInt(request.getParameter("pageSize"));

		pageNo = (pageNo == 0) ? 1 : pageNo;
		pageSize = (pageSize == 0) ? DataUtility.getInt(PropertyReader.getValue("page.size")) : pageSize;

		ProductBean bean = (ProductBean) populateBean(request);
		ProductModel model = new ProductModel();

		String[] ids = request.getParameterValues("ids");
		String op = DataUtility.getString(request.getParameter("operation"));

		try {
			if (OP_SEARCH.equalsIgnoreCase(op)) {
				pageNo = 1;
			} else if (OP_NEXT.equalsIgnoreCase(op)) {
				pageNo++;
			} else if (OP_PREVIOUS.equalsIgnoreCase(op) && pageNo > 1) {
				pageNo--;
			} else if (OP_NEW.equalsIgnoreCase(op)) {
				ServletUtility.redirect(SOTGView.PRODUCT_CTL, request, response);
				return;
			} else if (OP_DELETE.equalsIgnoreCase(op)) {
				pageNo = 1;
				if (ids != null && ids.length > 0) {
					for (String id : ids) {
						ProductBean deleteBean = new ProductBean();
						deleteBean.setId(DataUtility.getInt(id));
						model.delete(deleteBean);
					}
					ServletUtility.setSuccessMessage("Data Deleted Successfully", request);
				} else {
					ServletUtility.setErrorMessage("Select at least one record", request);
				}
			} else if (OP_RESET.equalsIgnoreCase(op)) {
				ServletUtility.redirect(SOTGView.PRODUCT_LIST_CTL, request, response);
				return;
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
			log.error("Exception in ProductListCtl doPost", e);
			ServletUtility.handleException(e, request, response);
		}

		log.debug("ProductListCtl doPost method end");
	}

	@Override
	protected String getView() {
		return SOTGView.PRODUCT_LIST_VIEW;
	}
}
