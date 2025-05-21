

package pitchperfect.bean;

import java.sql.Timestamp;

public class CourtBookingBean extends BaseBean {
    private long futsalCourtId;
    private String userName;
    private String bookingDate; // Format: YYYY-MM-DD
    private String bookingDay;  // e.g. Monday
    private String bookingTime; // Format: HH:mm
    private int duration;

    // Getters and Setters
    public long getFutsalCourtId() {
        return futsalCourtId;
    }

    public void setFutsalCourtId(long futsalCourtId) {
        this.futsalCourtId = futsalCourtId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getBookingDay() {
        return bookingDay;
    }

    public void setBookingDay(String bookingDay) {
        this.bookingDay = bookingDay;
    }

    public String getBookingTime() {
        return bookingTime;
    }

    public void setBookingTime(String bookingTime) {
        this.bookingTime = bookingTime;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    // Implementing abstract methods from BaseBean / DropDownListBean
    @Override
    public String getKey() {
        return String.valueOf(id); // Assuming 'id' is defined in BaseBean
    }

    @Override
    public String getValue() {
        // You can return any value suitable for UI display, e.g., a summary
        return userName + " - " + bookingDate + " at " + bookingTime;
    }
}























//
//
//package pitchperfect.bean;
//
//import java.sql.Timestamp;
//
//public class CourtBookingBean extends BaseBean {
//    private long futsalCourtId;
//    private String userName;
//    private String bookingDate; // YYYY-MM-DD
//    private String bookingDay;  // e.g. Monday
//    private String bookingTime; // HH:mm
//    private int duration;
//
//    public long getFutsalCourtId() {
//        return futsalCourtId;
//    }
//
//    public void setFutsalCourtId(long futsalCourtId) {
//        this.futsalCourtId = futsalCourtId;
//    }
//
//    public String getUserName() {
//        return userName;
//    }
//
//    public void setUserName(String userName) {
//        this.userName = userName;
//    }
//
//    public String getBookingDate() {
//        return bookingDate;
//    }
//
//    public void setBookingDate(String bookingDate) {
//        this.bookingDate = bookingDate;
//    }
//
//    public String getBookingDay() {
//        return bookingDay;
//    }
//
//    public void setBookingDay(String bookingDay) {
//        this.bookingDay = bookingDay;
//    }
//
//    public String getBookingTime() {
//        return bookingTime;
//    }
//
//    public void setBookingTime(String bookingTime) {
//        this.bookingTime = bookingTime;
//    }
//
//    public int getDuration() {
//        return duration;
//    }
//
//    public void setDuration(int duration) {
//        this.duration = duration;
//    }
//}
