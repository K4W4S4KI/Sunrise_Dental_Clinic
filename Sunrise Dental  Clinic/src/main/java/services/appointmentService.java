package services;

import controller.DBConnect;
import model.appointment;
import model.dentist;
import model.treatment;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class appointmentService {

    // Consultation Fee
    public static final BigDecimal CONSULTATION_FEE =
            new BigDecimal("500.00");


 // =========================================================
 // GET ACTIVE DENTISTS
 // =========================================================
 public ArrayList<dentist> getActiveDentists() {

     ArrayList<dentist> dentistList = new ArrayList<>();

     String sql =
             "SELECT dentist_id, dentist_name, specialization, " +
             "contact_number, status " +
             "FROM dentist_tb " +
             "WHERE TRIM(status) = 'Active' " +
             "ORDER BY dentist_name ASC";

     try (
             Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()
     ) {

         while (rs.next()) {

             dentist d = new dentist();

             d.setDentist_id(
                     rs.getInt("dentist_id")
             );

             d.setDentist_name(
                     rs.getString("dentist_name")
             );

             d.setSpecialization(
                     rs.getString("specialization")
             );

             d.setContact_number(
                     rs.getString("contact_number")
             );

             d.setStatus(
                     rs.getString("status")
             );

             dentistList.add(d);
         }

         System.out.println(
                 "================================="
         );

         System.out.println(
                 "ACTIVE DENTISTS = "
                 + dentistList.size()
         );

         for (dentist d : dentistList) {

             System.out.println(
                     d.getDentist_id()
                     + " | "
                     + d.getDentist_name()
                     + " | "
                     + d.getSpecialization()
                     + " | "
                     + d.getStatus()
             );
         }

         System.out.println(
                 "================================="
         );

     } catch (Exception e) {

         System.out.println(
                 "ERROR loading dentists: "
                 + e.getMessage()
         );

         e.printStackTrace();
     }

     return dentistList;
 }

    // =========================================================
    // GET ACTIVE TREATMENTS
    // =========================================================

    public ArrayList<treatment> getActiveTreatments() {

        ArrayList<treatment> treatmentList =
                new ArrayList<>();

        String sql =
                "SELECT treatment_id, treatment_name, " +
                "treatment_priceLkr, status " +
                "FROM treatment_tb " +
                "WHERE status = 'Active' " +
                "ORDER BY treatment_id ASC";

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()
        ) {

            while (rs.next()) {

                treatment t = new treatment();

                t.setTreatment_id(
                        rs.getInt("treatment_id")
                );

                t.setTreatment_name(
                        rs.getString("treatment_name")
                );

                t.setTreatment_priceLkr(
                        rs.getBigDecimal(
                                "treatment_priceLkr"
                        )
                );

                t.setStatus(
                        rs.getString("status")
                );

                treatmentList.add(t);
            }

            System.out.println(
                    "Active treatments loaded: "
                    + treatmentList.size()
            );

        } catch (Exception e) {

            System.out.println(
                    "ERROR loading active treatments: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return treatmentList;
    }


    // =========================================================
    // GET ALL APPOINTMENTS
    // =========================================================

    public ArrayList<appointment> getAllAppointments() {

        ArrayList<appointment> appointmentList =
                new ArrayList<>();

        String sql =
                "SELECT a.appointment_id, " +
                "a.appointment_number, " +
                "a.p_id, " +
                "a.p_name, " +
                "a.address, " +
                "a.c_number, " +
                "a.gender, " +
                "a.d_id, " +
                "d.dentist_name, " +
                "a.appointment_datetime, " +
                "a.status " +

                "FROM appointment_tb a " +

                "JOIN dentist_tb d " +
                "ON a.d_id = d.dentist_id " +

                "ORDER BY a.appointment_datetime DESC";

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement stmt =
                        conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()
        ) {

            while (rs.next()) {

                appointment appt = new appointment();

                appt.setAppointment_id(
                        rs.getInt("appointment_id")
                );

                appt.setAppointment_number(
                        rs.getString(
                                "appointment_number"
                        )
                );

                appt.setP_id(
                        rs.getInt("p_id")
                );

                appt.setP_name(
                        rs.getString("p_name")
                );

                appt.setAddress(
                        rs.getString("address")
                );

                appt.setC_number(
                        rs.getString("c_number")
                );

                appt.setGender(
                        rs.getString("gender")
                );

                appt.setD_id(
                        rs.getInt("d_id")
                );

                appt.setAppointment_datetime(
                        rs.getTimestamp(
                                "appointment_datetime"
                        )
                );

                appt.setStatus(
                        rs.getString("status")
                );

                appointmentList.add(appt);
            }

            System.out.println(
                    "Appointments loaded: "
                    + appointmentList.size()
            );

        } catch (Exception e) {

            System.out.println(
                    "ERROR loading appointments: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return appointmentList;
    }


    // =========================================================
    // GET APPOINTMENT BY ID
    // =========================================================

    public appointment getAppointmentById(
            int appointmentId) {

        appointment appt = null;

        String sql =
                "SELECT appointment_id, " +
                "appointment_number, " +
                "p_id, " +
                "p_name, " +
                "address, " +
                "c_number, " +
                "gender, " +
                "d_id, " +
                "appointment_datetime, " +
                "status " +

                "FROM appointment_tb " +

                "WHERE appointment_id = ?";

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement stmt =
                        conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, appointmentId);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    appt = new appointment();

                    appt.setAppointment_id(
                            rs.getInt("appointment_id")
                    );

                    appt.setAppointment_number(
                            rs.getString(
                                    "appointment_number"
                            )
                    );

                    appt.setP_id(
                            rs.getInt("p_id")
                    );

                    appt.setP_name(
                            rs.getString("p_name")
                    );

                    appt.setAddress(
                            rs.getString("address")
                    );

                    appt.setC_number(
                            rs.getString("c_number")
                    );

                    appt.setGender(
                            rs.getString("gender")
                    );

                    appt.setD_id(
                            rs.getInt("d_id")
                    );

                    appt.setAppointment_datetime(
                            rs.getTimestamp(
                                    "appointment_datetime"
                            )
                    );

                    appt.setStatus(
                            rs.getString("status")
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR loading appointment: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return appt;
    }


    // =========================================================
    // GET APPOINTMENT SUMMARY
    // =========================================================

    public appointment getAppointmentSummary(
            int appointmentId) {

        appointment appt = null;

        String sql =
                "SELECT a.appointment_id, " +
                "a.appointment_number, " +
                "a.p_id, " +
                "a.p_name, " +
                "a.address, " +
                "a.c_number, " +
                "a.gender, " +
                "a.d_id, " +
                "d.dentist_name, " +
                "a.appointment_datetime, " +
                "a.status " +

                "FROM appointment_tb a " +

                "JOIN dentist_tb d " +
                "ON a.d_id = d.dentist_id " +

                "WHERE a.appointment_id = ?";

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement stmt =
                        conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, appointmentId);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    appt = new appointment();

                    appt.setAppointment_id(
                            rs.getInt("appointment_id")
                    );

                    appt.setAppointment_number(
                            rs.getString(
                                    "appointment_number"
                            )
                    );

                    appt.setP_id(
                            rs.getInt("p_id")
                    );

                    appt.setP_name(
                            rs.getString("p_name")
                    );

                    appt.setAddress(
                            rs.getString("address")
                    );

                    appt.setC_number(
                            rs.getString("c_number")
                    );

                    appt.setGender(
                            rs.getString("gender")
                    );

                    appt.setD_id(
                            rs.getInt("d_id")
                    );

                    appt.setAppointment_datetime(
                            rs.getTimestamp(
                                    "appointment_datetime"
                            )
                    );

                    appt.setStatus(
                            rs.getString("status")
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR loading appointment summary: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return appt;
    }


    // =========================================================
    // GET TREATMENT BY ID
    // =========================================================

    public treatment getTreatmentById(
            int treatmentId) {

        treatment t = null;

        String sql =
                "SELECT treatment_id, " +
                "treatment_name, " +
                "treatment_priceLkr, " +
                "status " +

                "FROM treatment_tb " +

                "WHERE treatment_id = ?";

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement stmt =
                        conn.prepareStatement(sql)
        ) {

            stmt.setInt(1, treatmentId);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    t = new treatment();

                    t.setTreatment_id(
                            rs.getInt("treatment_id")
                    );

                    t.setTreatment_name(
                            rs.getString(
                                    "treatment_name"
                            )
                    );

                    t.setTreatment_priceLkr(
                            rs.getBigDecimal(
                                    "treatment_priceLkr"
                            )
                    );

                    t.setStatus(
                            rs.getString("status")
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR loading treatment: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return t;
    }


    // =========================================================
    // CALCULATE TREATMENT TOTAL
    // =========================================================

    public BigDecimal calculateTreatmentTotal(
            List<treatment> treatmentList) {

        BigDecimal total = BigDecimal.ZERO;

        if (treatmentList == null) {
            return total;
        }

        for (treatment t : treatmentList) {

            if (t != null &&
                    t.getTreatment_priceLkr() != null) {

                total = total.add(
                        t.getTreatment_priceLkr()
                );
            }
        }

        return total;
    }


    // =========================================================
    // CALCULATE BILL TOTAL
    // =========================================================

    public BigDecimal calculateBillTotal(
            List<treatment> treatmentList) {

        return calculateTreatmentTotal(
                treatmentList
        ).add(CONSULTATION_FEE);
    }


    // =========================================================
    // CREATE APPOINTMENT
    // =========================================================

    public boolean createAppointment(
            appointment appt) {

        String sql =
                "INSERT INTO appointment_tb " +
                "(appointment_number, p_id, p_name, " +
                "address, c_number, gender, d_id, " +
                "appointment_datetime, status) " +

                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;

        try {

            conn = DBConnect.getConnection();

            conn.setAutoCommit(false);

            String appointmentNumber =
                    "APT-" + System.currentTimeMillis();


            try (
                    PreparedStatement stmt =
                            conn.prepareStatement(
                                    sql
                            )
            ) {

                stmt.setString(
                        1,
                        appointmentNumber
                );


                if (appt.getP_id() != null) {

                    stmt.setInt(
                            2,
                            appt.getP_id()
                    );

                } else {

                    stmt.setNull(
                            2,
                            java.sql.Types.INTEGER
                    );
                }


                stmt.setString(
                        3,
                        appt.getP_name()
                );

                stmt.setString(
                        4,
                        appt.getAddress()
                );

                stmt.setString(
                        5,
                        appt.getC_number()
                );

                stmt.setString(
                        6,
                        appt.getGender()
                );

                stmt.setInt(
                        7,
                        appt.getD_id()
                );

                stmt.setTimestamp(
                        8,
                        appt.getAppointment_datetime()
                );

                stmt.setString(
                        9,
                        "Pending"
                );


                int rows =
                        stmt.executeUpdate();

                if (rows == 0) {

                    conn.rollback();
                    return false;
                }
            }

            conn.commit();

            System.out.println(
                    "Appointment created successfully."
            );

            return true;

        } catch (Exception e) {

            System.out.println(
                    "ERROR creating appointment: "
                    + e.getMessage()
            );

            e.printStackTrace();

            if (conn != null) {

                try {
                    conn.rollback();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }

            return false;

        } finally {

            if (conn != null) {

                try {

                    conn.setAutoCommit(true);
                    conn.close();

                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }


    // =========================================================
    // UPDATE APPOINTMENT
    // =========================================================

    public boolean updateAppointment(
            appointment appt) {

        String sql =
                "UPDATE appointment_tb SET " +
                "p_name = ?, " +
                "address = ?, " +
                "c_number = ?, " +
                "gender = ?, " +
                "d_id = ?, " +
                "appointment_datetime = ?, " +
                "status = ? " +

                "WHERE appointment_id = ?";

        Connection conn = null;

        try {

            conn = DBConnect.getConnection();

            try (
                    PreparedStatement stmt =
                            conn.prepareStatement(sql)
            ) {

                stmt.setString(
                        1,
                        appt.getP_name()
                );

                stmt.setString(
                        2,
                        appt.getAddress()
                );

                stmt.setString(
                        3,
                        appt.getC_number()
                );

                stmt.setString(
                        4,
                        appt.getGender()
                );

                stmt.setInt(
                        5,
                        appt.getD_id()
                );

                stmt.setTimestamp(
                        6,
                        appt.getAppointment_datetime()
                );

                stmt.setString(
                        7,
                        appt.getStatus()
                );

                stmt.setInt(
                        8,
                        appt.getAppointment_id()
                );


                int rows =
                        stmt.executeUpdate();

                if (rows > 0) {

                    System.out.println(
                            "Appointment updated successfully. "
                            + "ID: "
                            + appt.getAppointment_id()
                    );

                    return true;
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR updating appointment: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // DELETE APPOINTMENT
    // =========================================================

    public boolean deleteAppointment(
            int appointmentId) {

        String sql =
                "DELETE FROM appointment_tb " +
                "WHERE appointment_id = ?";

        Connection conn = null;

        try {

            conn = DBConnect.getConnection();

            try (
                    PreparedStatement stmt =
                            conn.prepareStatement(sql)
            ) {

                stmt.setInt(
                        1,
                        appointmentId
                );

                int rows =
                        stmt.executeUpdate();

                if (rows > 0) {

                    System.out.println(
                            "Appointment deleted successfully. "
                            + "ID: "
                            + appointmentId
                    );

                    return true;
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR deleting appointment: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return false;
    }


    // =========================================================
    // SEARCH APPOINTMENT BY APPOINTMENT NUMBER
    // =========================================================

    public appointment getAppointmentByNumber(
            String appointmentNumber) {

        appointment appt = null;

        String sql =
                "SELECT appointment_id, " +
                "appointment_number, " +
                "p_id, " +
                "p_name, " +
                "address, " +
                "c_number, " +
                "gender, " +
                "d_id, " +
                "appointment_datetime, " +
                "status " +

                "FROM appointment_tb " +

                "WHERE appointment_number = ?";

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement stmt =
                        conn.prepareStatement(sql)
        ) {

            stmt.setString(
                    1,
                    appointmentNumber
            );

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    appt = new appointment();

                    appt.setAppointment_id(
                            rs.getInt("appointment_id")
                    );

                    appt.setAppointment_number(
                            rs.getString(
                                    "appointment_number"
                            )
                    );

                    appt.setP_id(
                            rs.getInt("p_id")
                    );

                    appt.setP_name(
                            rs.getString("p_name")
                    );

                    appt.setAddress(
                            rs.getString("address")
                    );

                    appt.setC_number(
                            rs.getString("c_number")
                    );

                    appt.setGender(
                            rs.getString("gender")
                    );

                    appt.setD_id(
                            rs.getInt("d_id")
                    );

                    appt.setAppointment_datetime(
                            rs.getTimestamp(
                                    "appointment_datetime"
                            )
                    );

                    appt.setStatus(
                            rs.getString("status")
                    );
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR searching appointment: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return appt;
    }


    // =========================================================
    // CHECK DENTIST AVAILABILITY
    // =========================================================

    public boolean isDentistAvailable(
            int dentistId,
            java.sql.Timestamp appointmentDatetime,
            int appointmentId) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM appointment_tb " +
                "WHERE d_id = ? " +
                "AND appointment_datetime = ? " +
                "AND appointment_id <> ? " +
                "AND status <> 'Cancelled'";

        try (
                Connection conn = DBConnect.getConnection();
                PreparedStatement stmt =
                        conn.prepareStatement(sql)
        ) {

            stmt.setInt(
                    1,
                    dentistId
            );

            stmt.setTimestamp(
                    2,
                    appointmentDatetime
            );

            stmt.setInt(
                    3,
                    appointmentId
            );

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {

                    return rs.getInt(1) == 0;
                }
            }

        } catch (Exception e) {

            System.out.println(
                    "ERROR checking dentist availability: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return false;
    }
    
 // =========================================================
 // CREATE APPOINTMENT WITH MULTIPLE TREATMENTS
 // =========================================================

 public boolean createAppointmentWithTreatments(
         appointment appt,
         String[] treatmentIds) {

     Connection conn = null;

     String appointmentSql =
             "INSERT INTO appointment_tb " +
             "(appointment_number, p_id, p_name, address, " +
             "c_number, gender, d_id, appointment_datetime, status) " +
             "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";


     String treatmentSql =
             "INSERT INTO appointment_treatment_tb " +
             "(appointment_id, treatment_id, treatment_price) " +
             "VALUES (?, ?, ?)";


     try {

         conn = DBConnect.getConnection();

         conn.setAutoCommit(false);


         // -------------------------------------------------
         // GENERATE APPOINTMENT NUMBER
         // -------------------------------------------------

         String appointmentNumber =
                 "APT-" + System.currentTimeMillis();


         int appointmentId;


         // -------------------------------------------------
         // INSERT APPOINTMENT
         // -------------------------------------------------

         try (
                 PreparedStatement stmt =
                         conn.prepareStatement(
                                 appointmentSql,
                                 java.sql.Statement.RETURN_GENERATED_KEYS
                         )
         ) {

             stmt.setString(
                     1,
                     appointmentNumber
             );


             if (appt.getP_id() != null) {

                 stmt.setInt(
                         2,
                         appt.getP_id()
                 );

             } else {

                 stmt.setNull(
                         2,
                         java.sql.Types.INTEGER
                 );
             }


             stmt.setString(
                     3,
                     appt.getP_name()
             );

             stmt.setString(
                     4,
                     appt.getAddress()
             );

             stmt.setString(
                     5,
                     appt.getC_number()
             );

             stmt.setString(
                     6,
                     appt.getGender()
             );

             stmt.setInt(
                     7,
                     appt.getD_id()
             );

             stmt.setTimestamp(
                     8,
                     appt.getAppointment_datetime()
             );

             stmt.setString(
                     9,
                     "Pending"
             );


             int rows =
                     stmt.executeUpdate();


             if (rows == 0) {

                 conn.rollback();

                 return false;
             }


             try (
                     ResultSet keys =
                             stmt.getGeneratedKeys()
             ) {

                 if (keys.next()) {

                     appointmentId =
                             keys.getInt(1);

                 } else {

                     conn.rollback();

                     return false;
                 }
             }
         }


         // -------------------------------------------------
         // INSERT SELECTED TREATMENTS
         // -------------------------------------------------

         try (
                 PreparedStatement treatmentStmt =
                         conn.prepareStatement(
                                 treatmentSql
                         )
         ) {

             for (String treatmentIdStr :
                     treatmentIds) {

                 int treatmentId =
                         Integer.parseInt(
                                 treatmentIdStr
                         );


                 // Get current treatment price

                 BigDecimal price = null;


                 String priceSql =
                         "SELECT treatment_priceLkr " +
                         "FROM treatment_tb " +
                         "WHERE treatment_id = ? " +
                         "AND status = 'Active'";


                 try (
                         PreparedStatement priceStmt =
                                 conn.prepareStatement(
                                         priceSql
                                 )
                 ) {

                     priceStmt.setInt(
                             1,
                             treatmentId
                     );


                     try (
                             ResultSet rs =
                                     priceStmt.executeQuery()
                     ) {

                         if (rs.next()) {

                             price =
                                     rs.getBigDecimal(
                                             "treatment_priceLkr"
                                     );
                         }
                     }
                 }


                 if (price == null) {

                     conn.rollback();

                     return false;
                 }


                 treatmentStmt.setInt(
                         1,
                         appointmentId
                 );

                 treatmentStmt.setInt(
                         2,
                         treatmentId
                 );

                 treatmentStmt.setBigDecimal(
                         3,
                         price
                 );

                 treatmentStmt.addBatch();
             }


             treatmentStmt.executeBatch();
         }


         // -------------------------------------------------
         // COMMIT
         // -------------------------------------------------

         conn.commit();


         System.out.println(
                 "Appointment created: "
                 + appointmentNumber
         );


         return true;


     } catch (Exception e) {

         e.printStackTrace();


         if (conn != null) {

             try {
                 conn.rollback();
             } catch (Exception ex) {
                 ex.printStackTrace();
             }
         }


         return false;


     } finally {

         if (conn != null) {

             try {

                 conn.setAutoCommit(true);
                 conn.close();

             } catch (Exception e) {

                 e.printStackTrace();
             }
         }
     }
 }
}

