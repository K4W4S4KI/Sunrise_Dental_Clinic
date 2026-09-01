package services;

import controller.DBConnect;
import model.dentist;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class dentistService {

    public ArrayList<dentist> getActiveDentists() {

        ArrayList<dentist> dentistList = new ArrayList<>();

        String sql = "SELECT dentist_id, dentist_name, specialization, "
                   + "contact_number, status "
                   + "FROM dentist_tb "
                   + "WHERE status = 'Active' "
                   + "ORDER BY dentist_name ASC";

        try (
            Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                dentist d = new dentist();

                d.setDentist_id(rs.getInt("dentist_id"));
                d.setDentist_name(rs.getString("dentist_name"));
                d.setSpecialization(rs.getString("specialization"));
                d.setContact_number(rs.getString("contact_number"));
                d.setStatus(rs.getString("status"));

                dentistList.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return dentistList;
    }
}