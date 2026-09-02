package services;

import controller.DBConnect;
import model.patient;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class patientService {

    // =========================================================
    // GET ALL PATIENTS
    // =========================================================

    public ArrayList<patient> getAllPatients() {

        ArrayList<patient> patientList = new ArrayList<>();

        String sql =
            "SELECT p_id, p_name, address, c_number, gender, " +
            "register_datetime, status " +
            "FROM patient_tb " +
            "ORDER BY p_id DESC";

        try (
            Connection conn = DBConnect.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()
        ) {

            while (rs.next()) {

                patient pat = new patient();

                pat.setP_id(rs.getInt("p_id"));
                pat.setP_name(rs.getString("p_name"));
                pat.setAddress(rs.getString("address"));
                pat.setC_number(rs.getString("c_number"));
                pat.setGender(rs.getString("gender"));
                pat.setRegister_datetime(
                    rs.getTimestamp("register_datetime")
                );
                pat.setStatus(rs.getString("status"));

                patientList.add(pat);
            }

        } catch (Exception e) {

            System.out.println("GET ALL PATIENTS ERROR: "
                    + e.getMessage());

            e.printStackTrace();
        }

        return patientList;
    }


    // =========================================================
    // SEARCH PATIENTS
    // =========================================================

    public ArrayList<patient> searchPatients(String keyword) {

        ArrayList<patient> patientList = new ArrayList<>();

        String sql =
            "SELECT p_id, p_name, address, c_number, gender, " +
            "register_datetime, status " +
            "FROM patient_tb " +
            "WHERE CAST(p_id AS CHAR) LIKE ? " +
            "OR p_name LIKE ? " +
            "OR c_number LIKE ? " +
            "ORDER BY p_id DESC";

        try (
            Connection conn = DBConnect.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            String search = "%" + keyword.trim() + "%";

            stmt.setString(1, search);
            stmt.setString(2, search);
            stmt.setString(3, search);

            try (ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {

                    patient pat = new patient();

                    pat.setP_id(rs.getInt("p_id"));
                    pat.setP_name(rs.getString("p_name"));
                    pat.setAddress(rs.getString("address"));
                    pat.setC_number(rs.getString("c_number"));
                    pat.setGender(rs.getString("gender"));
                    pat.setRegister_datetime(
                        rs.getTimestamp("register_datetime")
                    );
                    pat.setStatus(rs.getString("status"));

                    patientList.add(pat);
                }
            }

        } catch (Exception e) {

            System.out.println("SEARCH PATIENT ERROR: "
                    + e.getMessage());

            e.printStackTrace();
        }

        return patientList;
    }


    // =========================================================
    // GET PATIENT BY ID
    // =========================================================

    public patient getPatientById(int patientId) {

        patient pat = null;

        String sql =
            "SELECT p_id, p_name, address, c_number, gender, " +
            "register_datetime, status " +
            "FROM patient_tb " +
            "WHERE p_id = ?";

        try (
            Connection conn = DBConnect.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, patientId);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    pat = new patient();

                    pat.setP_id(rs.getInt("p_id"));
                    pat.setP_name(rs.getString("p_name"));
                    pat.setAddress(rs.getString("address"));
                    pat.setC_number(rs.getString("c_number"));
                    pat.setGender(rs.getString("gender"));
                    pat.setRegister_datetime(
                        rs.getTimestamp("register_datetime")
                    );
                    pat.setStatus(rs.getString("status"));
                }
            }

        } catch (Exception e) {

            System.out.println("GET PATIENT BY ID ERROR: "
                    + e.getMessage());

            e.printStackTrace();
        }

        return pat;
    }


    // =========================================================
    // GET PATIENT BY CONTACT NUMBER
    // =========================================================

    public patient getPatientByContactNumber(String contactNumber) {

        if (contactNumber == null ||
            contactNumber.trim().isEmpty()) {

            return null;
        }

        patient pat = null;

        String sql =
            "SELECT p_id, p_name, address, c_number, gender, " +
            "register_datetime, status " +
            "FROM patient_tb " +
            "WHERE c_number = ? " +
            "LIMIT 1";

        try (
            Connection conn = DBConnect.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, contactNumber.trim());

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    pat = new patient();

                    pat.setP_id(rs.getInt("p_id"));
                    pat.setP_name(rs.getString("p_name"));
                    pat.setAddress(rs.getString("address"));
                    pat.setC_number(rs.getString("c_number"));
                    pat.setGender(rs.getString("gender"));
                    pat.setRegister_datetime(
                        rs.getTimestamp("register_datetime")
                    );
                    pat.setStatus(rs.getString("status"));
                }
            }

        } catch (Exception e) {

            System.out.println(
                "GET PATIENT BY CONTACT ERROR: "
                + e.getMessage()
            );

            e.printStackTrace();
        }

        return pat;
    }


    // =========================================================
    // ADD PATIENT
    // =========================================================

    public boolean addPatient(patient pat) {

        String sql =
            "INSERT INTO patient_tb " +
            "(p_name, address, c_number, gender, status) " +
            "VALUES (?, ?, ?, ?, ?)";

        try (
            Connection conn = DBConnect.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, pat.getP_name());
            stmt.setString(2, pat.getAddress());
            stmt.setString(3, pat.getC_number());
            stmt.setString(4, pat.getGender());

            String status = pat.getStatus();

            if (status == null ||
                status.trim().isEmpty()) {

                status = "Active";
            }

            stmt.setString(5, status);

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                "ADD PATIENT ERROR: "
                + e.getMessage()
            );

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // UPDATE PATIENT
    // =========================================================

    public boolean updatePatient(patient pat) {

        String sql =
            "UPDATE patient_tb SET " +
            "p_name = ?, " +
            "address = ?, " +
            "c_number = ?, " +
            "gender = ?, " +
            "status = ? " +
            "WHERE p_id = ?";

        try (
            Connection conn = DBConnect.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setString(1, pat.getP_name());
            stmt.setString(2, pat.getAddress());
            stmt.setString(3, pat.getC_number());
            stmt.setString(4, pat.getGender());

            String status = pat.getStatus();

            if (status == null ||
                status.trim().isEmpty()) {

                status = "Active";
            }

            stmt.setString(5, status);
            stmt.setInt(6, pat.getP_id());

            int rows = stmt.executeUpdate();

            System.out.println(
                "UPDATE PATIENT ID: " + pat.getP_id()
            );

            System.out.println(
                "ROWS UPDATED: " + rows
            );

            return rows > 0;

        } catch (Exception e) {

            System.out.println(
                "UPDATE PATIENT ERROR: "
                + e.getMessage()
            );

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // DELETE PATIENT
    // =========================================================

    public boolean deletePatient(int patientId) {

        String sql =
            "DELETE FROM patient_tb WHERE p_id = ?";

        try (
            Connection conn = DBConnect.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, patientId);

            int rows = stmt.executeUpdate();

            System.out.println(
                "DELETE PATIENT ID: " + patientId
            );

            System.out.println(
                "ROWS DELETED: " + rows
            );

            return rows > 0;

        } catch (Exception e) {

            System.out.println(
                "===================================="
            );

            System.out.println(
                "DELETE PATIENT ERROR"
            );

            System.out.println(
                "PATIENT ID: " + patientId
            );

            System.out.println(
                "ERROR MESSAGE: " + e.getMessage()
            );

            System.out.println(
                "===================================="
            );

            e.printStackTrace();

            return false;
        }
    }
    
 // =========================================================
 // GET TOTAL PATIENT COUNT
 // =========================================================

 public int getTotalPatientCount() {

     String sql = "SELECT COUNT(*) FROM patient_tb";

     try (
         Connection conn = DBConnect.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()
     ) {

         if (rs.next()) {
             return rs.getInt(1);
         }

     } catch (Exception e) {

         System.out.println("GET TOTAL PATIENT COUNT ERROR: "
                 + e.getMessage());

         e.printStackTrace();
     }

     return 0;
 }
}