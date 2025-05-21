package pitchperfect.model;

import java.sql.*;
import pitchperfect.bean.FutsalCourtBean;
import pitchperfect.exception.ApplicationException;
import pitchperfect.util.JDBCDataSource;
import java.util.ArrayList;
import java.util.List;

public class FutsalCourtModel {

    public long add(FutsalCourtBean bean) throws ApplicationException {
        String sql = "INSERT INTO futsal_courts (name, description, price_per_hour, location, image, created_by, modified_by, created_datetime) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        long pk = 0;
        try (Connection conn = JDBCDataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, bean.getName());
            pstmt.setString(2, bean.getDescription());
            pstmt.setDouble(3, bean.getPricePerHour());
            pstmt.setString(4, bean.getLocation());
            pstmt.setString(5, bean.getImage());
            pstmt.setString(6, bean.getCreatedBy());
            pstmt.setString(7, bean.getModifiedBy());
            pstmt.setTimestamp(8, new Timestamp(System.currentTimeMillis()));

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        pk = rs.getLong(1);
                    }
                }
            }

        } catch (SQLException | RuntimeException e) {
            throw new ApplicationException("Exception in add(): " + e.getMessage(), e);
        }

        return pk;
    }

    public void update(FutsalCourtBean bean) throws ApplicationException {
        String sql = "UPDATE futsal_courts SET name = ?, description = ?, price_per_hour = ?, location = ?, image = ?, modified_by = ?, modified_datetime = ? WHERE id = ?";

        try (Connection conn = JDBCDataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, bean.getName());
            pstmt.setString(2, bean.getDescription());
            pstmt.setDouble(3, bean.getPricePerHour());
            pstmt.setString(4, bean.getLocation());
            pstmt.setString(5, bean.getImage());
            pstmt.setString(6, bean.getModifiedBy());
            pstmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
            pstmt.setLong(8, bean.getId());

            if (pstmt.executeUpdate() == 0) {
                throw new ApplicationException("No record found to update for ID: " + bean.getId());
            }

        } catch (SQLException | RuntimeException e) {
            throw new ApplicationException("Exception in update(): " + e.getMessage(), e);
        }
    }

    public void delete(long id) throws ApplicationException {
        String sql = "DELETE FROM futsal_courts WHERE id = ?";

        try (Connection conn = JDBCDataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, id);
            if (pstmt.executeUpdate() == 0) {
                throw new ApplicationException("No record found to delete for ID: " + id);
            }

        } catch (SQLException | RuntimeException e) {
            throw new ApplicationException("Exception in delete(): " + e.getMessage(), e);
        }
    }

    public FutsalCourtBean findByPK(long id) throws ApplicationException {
        FutsalCourtBean bean = null;
        String sql = "SELECT * FROM futsal_courts WHERE id = ?";

        try (Connection conn = JDBCDataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setLong(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    bean = new FutsalCourtBean();
                    bean.setId(rs.getLong("id"));
                    bean.setName(rs.getString("name"));
                    bean.setDescription(rs.getString("description"));
                    bean.setPricePerHour(rs.getDouble("price_per_hour"));
                    bean.setLocation(rs.getString("location"));
                    bean.setImage(rs.getString("image"));
                    bean.setCreatedBy(rs.getString("created_by"));
                    bean.setModifiedBy(rs.getString("modified_by"));
                    bean.setCreatedDatetime(rs.getTimestamp("created_datetime"));
                    bean.setModifiedDatetime(rs.getTimestamp("modified_datetime"));
                }
            }

        } catch (SQLException | RuntimeException e) {
            throw new ApplicationException("Exception in findByPK(): " + e.getMessage(), e);
        }

        return bean;
    }

    public List<FutsalCourtBean> list() throws ApplicationException {
        List<FutsalCourtBean> list = new ArrayList<>();
        String sql = "SELECT * FROM futsal_courts ORDER BY id";

        try (Connection conn = JDBCDataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                FutsalCourtBean bean = new FutsalCourtBean();
                bean.setId(rs.getLong("id"));
                bean.setName(rs.getString("name"));
                bean.setDescription(rs.getString("description"));
                bean.setPricePerHour(rs.getDouble("price_per_hour"));
                bean.setLocation(rs.getString("location"));
                bean.setImage(rs.getString("image"));
                bean.setCreatedBy(rs.getString("created_by"));
                bean.setModifiedBy(rs.getString("modified_by"));
                bean.setCreatedDatetime(rs.getTimestamp("created_datetime"));
                bean.setModifiedDatetime(rs.getTimestamp("modified_datetime"));
                list.add(bean);
            }

        } catch (SQLException | RuntimeException e) {
            throw new ApplicationException("Exception in list(): " + e.getMessage(), e);
        }

        return list;
    }

    // Fixed search method with proper exception handling
    public List<FutsalCourtBean> search(FutsalCourtBean bean, int pageNo, int pageSize) throws ApplicationException {
        List<FutsalCourtBean> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM futsal_courts WHERE 1=1");

        if (bean != null && bean.getName() != null && !bean.getName().trim().isEmpty()) {
            sql.append(" AND name LIKE ?");
        }

        sql.append(" ORDER BY id");

        if (pageSize > 0) {
            int offset = (pageNo - 1) * pageSize;
            sql.append(" LIMIT ").append(offset).append(", ").append(pageSize);
        }

        try (Connection conn = JDBCDataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (bean != null && bean.getName() != null && !bean.getName().trim().isEmpty()) {
                pstmt.setString(paramIndex++, bean.getName().trim() + "%");
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    FutsalCourtBean resultBean = new FutsalCourtBean();
                    resultBean.setId(rs.getLong("id"));
                    resultBean.setName(rs.getString("name"));
                    resultBean.setDescription(rs.getString("description"));
                    resultBean.setPricePerHour(rs.getDouble("price_per_hour"));
                    resultBean.setLocation(rs.getString("location"));
                    resultBean.setCreatedBy(rs.getString("created_by"));
                    resultBean.setModifiedBy(rs.getString("modified_by"));
                    resultBean.setCreatedDatetime(rs.getTimestamp("created_datetime"));
                    resultBean.setModifiedDatetime(rs.getTimestamp("modified_datetime"));
                    list.add(resultBean);
                }
            }

        } catch (SQLException e) {
            throw new ApplicationException("Database error in search(): " + e.getMessage(), e);
        } catch (Exception e) {
            throw new ApplicationException("Unexpected error in search(): " + e.getMessage(), e);
        }

        return list;
    }
}
