package pitchperfect.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import pitchperfect.bean.CourtBookingBean;
import pitchperfect.exception.ApplicationException;
import pitchperfect.util.JDBCDataSource;

public class CourtBookingModel {

    public List<CourtBookingBean> list() throws ApplicationException {
        List<CourtBookingBean> list = new ArrayList<>();
        String sql = "SELECT * FROM court_bookings";

        try (Connection conn = JDBCDataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                CourtBookingBean bean = new CourtBookingBean();
                bean.setId(rs.getLong("id"));
                bean.setFutsalCourtId(rs.getLong("futsal_court_id"));
                bean.setUserName(rs.getString("user_name"));
                bean.setBookingDate(rs.getTimestamp("booking_date_time").toString());
                bean.setBookingDay(rs.getString("booking_day"));
                bean.setBookingTime(rs.getTime("booking_time").toString());
                bean.setDuration(rs.getInt("duration"));
                bean.setCreatedBy(rs.getString("created_by"));
                bean.setModifiedBy(rs.getString("modified_by"));
                bean.setCreatedDatetime(rs.getTimestamp("created_datetime"));
                bean.setModifiedDatetime(rs.getTimestamp("modified_datetime"));
                list.add(bean);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ApplicationException("Exception in list CourtBooking: " + e.getMessage(), e);
        }

        return list;
    }

    // Add booking, using courtId directly
    public long add(CourtBookingBean bean) throws ApplicationException {
        String sql = "INSERT INTO court_bookings(futsal_court_id, user_name, booking_date_time, booking_day, booking_time, duration, created_by, modified_by, created_datetime, modified_datetime) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
        long pk = 0;

        try (Connection conn = JDBCDataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Use the courtId directly without converting from courtName
            ps.setLong(1, bean.getFutsalCourtId());
            ps.setString(2, bean.getUserName());

            // Booking Date
            String bookingDate = bean.getBookingDate();
            if (bookingDate != null && !bookingDate.isEmpty()) {
                try {
                    String formattedDate = bookingDate + " 00:00:00"; // Default time: midnight
                    ps.setTimestamp(3, Timestamp.valueOf(formattedDate));
                } catch (IllegalArgumentException e) {
                    throw new ApplicationException("Invalid booking date format. Expected yyyy-MM-dd", e);
                }
            } else {
                ps.setNull(3, java.sql.Types.TIMESTAMP);
            }

            ps.setString(4, bean.getBookingDay());

            // Booking Time
            String bookingTime = bean.getBookingTime();
            if (bookingTime != null && !bookingTime.isEmpty()) {
                try {
                    if (bookingTime.matches("^([01]?[0-9]|2[0-3]):([0-5]?[0-9])$")) {
                        bookingTime += ":00"; // Ensure full time format
                    }
                    if (!bookingTime.matches("^([01]?[0-9]|2[0-3]):([0-5]?[0-9]):([0-5]?[0-9])$")) {
                        throw new IllegalArgumentException("Invalid time format. Expected HH:mm:ss.");
                    }
                    ps.setTime(5, Time.valueOf(bookingTime));
                } catch (IllegalArgumentException e) {
                    throw new ApplicationException("Invalid booking time format. Expected HH:mm:ss", e);
                }
            } else {
                ps.setNull(5, java.sql.Types.TIME);
            }

            ps.setInt(6, bean.getDuration());
            ps.setString(7, bean.getCreatedBy());
            ps.setString(8, bean.getModifiedBy());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                pk = rs.getLong(1);
            }

        } catch (SQLException e) {
            throw new ApplicationException("Exception in add CourtBooking: " + e.getMessage(), e);
        }

        return pk;
    }
}
