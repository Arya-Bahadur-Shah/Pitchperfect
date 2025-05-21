package pitchperfect.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import pitchperfect.bean.CourtBookingBean;
import pitchperfect.exception.ApplicationException;
import pitchperfect.model.CourtBookingModel;
import pitchperfect.util.DataUtility;
import pitchperfect.util.ServletUtility;

import java.util.List;
import java.util.ArrayList;

@WebServlet(name = "CourtBookingCtl", urlPatterns = {"/ctl/CourtBookingCtl"})
public class CourtBookingCtl extends BaseCtl {

    private static final String FORM_VIEW = "/cjsp/CourtBookingForm.jsp";
    private static final String LIST_VIEW = "/cjsp/CourtBookingList.jsp";

    @Override
    protected String getView() {
        return FORM_VIEW; // Default view (used only in fallback)
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = DataUtility.getString(request.getParameter("operation"));

        try {
            if ("list".equalsIgnoreCase(op)) {
                CourtBookingModel model = new CourtBookingModel();
                List<CourtBookingBean> list = model.list();

                if (list == null) {
                    list = new ArrayList<>();
                }

                request.setAttribute("list", list);
                ServletUtility.forward(LIST_VIEW, request, response);
            } else {
                // Show form by default or for operation=form
                ServletUtility.forward(FORM_VIEW, request, response);
            }
        } catch (ApplicationException e) {
            e.printStackTrace();
            ServletUtility.handleException(e, request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CourtBookingBean bean = new CourtBookingBean();

        try {
            bean.setFutsalCourtId(DataUtility.getLong(request.getParameter("futsalCourtId")));
            bean.setUserName(DataUtility.getString(request.getParameter("userName")));
            bean.setBookingDate(DataUtility.getString(request.getParameter("bookingDate")));
            bean.setBookingDay(DataUtility.getString(request.getParameter("bookingDay")));
            bean.setBookingTime(DataUtility.getString(request.getParameter("bookingTime")));
            bean.setDuration(DataUtility.getInt(request.getParameter("duration")));
            bean.setCreatedBy("Admin");
            bean.setModifiedBy("Admin");

            // Validate and parse date
            String bookingDate = bean.getBookingDate();
            if (bookingDate != null && !bookingDate.isEmpty()) {
                if (bookingDate.length() == 10) {
                    try {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        java.util.Date utilDate = sdf.parse(bookingDate);
                        Date sqlDate = new Date(utilDate.getTime());
                        bean.setBookingDate(sqlDate.toString());
                    } catch (Exception e) {
                        throw new ApplicationException("Invalid booking date format", e);
                    }
                } else {
                    throw new ApplicationException("Invalid booking date format. Expected yyyy-MM-dd");
                }
            } else {
                throw new ApplicationException("Booking date cannot be empty.");
            }

            // Add booking
            CourtBookingModel model = new CourtBookingModel();
            model.add(bean);

            HttpSession session = request.getSession();
            session.setAttribute("success", "Booked Successfully");
            response.sendRedirect(request.getContextPath() + "/ctl/CourtBookingCtl?operation=list");


        } catch (ApplicationException e) {
            e.printStackTrace();
            ServletUtility.setErrorMessage(e.getMessage(), request);
            ServletUtility.forward(FORM_VIEW, request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Unhandled exception in doPost", e);
        }
    }
}




