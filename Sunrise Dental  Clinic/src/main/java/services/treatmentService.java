package services;

import controller.DBConnect;
import model.treatment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class treatmentService {

    public ArrayList<treatment> getActiveTreatments() {

        ArrayList<treatment> treatmentList = new ArrayList<>();

        String sql = "SELECT treatment_id, treatment_name, "
                   + "treatment_priceLkr, status "
                   + "FROM treatment_tb "
                   + "WHERE status = 'Active' "
                   + "ORDER BY treatment_name ASC";

        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
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
                    rs.getBigDecimal("treatment_priceLkr")
                );

                t.setStatus(
                    rs.getString("status")
                );

                treatmentList.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return treatmentList;
    }
}