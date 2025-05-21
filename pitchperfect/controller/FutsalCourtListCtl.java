package pitchperfect.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pitchperfect.bean.FutsalCourtBean;
import pitchperfect.exception.ApplicationException;
import pitchperfect.model.FutsalCourtModel;
import pitchperfect.util.DataUtility;
import pitchperfect.util.ServletUtility;

@WebServlet(name = "FutsalCourtListCtl", urlPatterns = {"/ctl/FutsalCourtListCtl"})
public class FutsalCourtListCtl extends BaseCtl {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int pageNo = DataUtility.getInt(request.getParameter("pageNo"));
        int pageSize = DataUtility.getInt(request.getParameter("pageSize"));

        pageNo = (pageNo == 0) ? 1 : pageNo;        // Default to page 1
        pageSize = (pageSize == 0) ? 10 : pageSize; // Default page size = 10

        FutsalCourtModel model = new FutsalCourtModel();

        try {
            String searchName = DataUtility.getString(request.getParameter("searchName"));
            
            FutsalCourtBean searchBean = new FutsalCourtBean();
            if (searchName != null && !searchName.trim().isEmpty()) {
                searchBean.setName(searchName);
            }

            List<FutsalCourtBean> list = model.search(searchBean, pageNo, pageSize);
            List<FutsalCourtBean> nextList = model.search(searchBean, pageNo + 1, pageSize);

            request.setAttribute("list", list);

            if (list == null || list.size() == 0) {
                ServletUtility.setErrorMessage("No record found", request);
            }

            request.setAttribute("pageNo", pageNo);
            request.setAttribute("pageSize", pageSize);

            request.setAttribute("noNextPage", (nextList == null || nextList.size() == 0));

            ServletUtility.forward(getView(), request, response);

        } catch (ApplicationException e) {
            ServletUtility.handleException(e, request, response);
            return;
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtility.handleException(new ApplicationException(e.getMessage()), request, response);
            return;
        }
    }

    @Override
    protected String getView() {
        return "/cjsp/FutsalCourtListView.jsp";
    }
}
