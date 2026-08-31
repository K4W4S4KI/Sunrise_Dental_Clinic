package model;

import java.sql.Timestamp;

public class appointment {

    private int appointment_id;
    private String appointment_number;

    private Integer p_id;
    private String p_name;
    private String address;
    private String c_number;
    private String gender;

    private int d_id;

    private Timestamp appointment_datetime;

    private String status;

    // Default Constructor
    public appointment() {
    }

    // Full Constructor
    public appointment(int appointment_id,
                        String appointment_number,
                        Integer p_id,
                        String p_name,
                        String address,
                        String c_number,
                        String gender,
                        int d_id,
                        Timestamp appointment_datetime,
                        String status) {

        this.appointment_id = appointment_id;
        this.appointment_number = appointment_number;
        this.p_id = p_id;
        this.p_name = p_name;
        this.address = address;
        this.c_number = c_number;
        this.gender = gender;
        this.d_id = d_id;
        this.appointment_datetime = appointment_datetime;
        this.status = status;
    }

    // Constructor without ID
    public appointment(String appointment_number,
                       Integer p_id,
                       String p_name,
                       String address,
                       String c_number,
                       String gender,
                       int d_id,
                       Timestamp appointment_datetime,
                       String status) {

        this.appointment_number = appointment_number;
        this.p_id = p_id;
        this.p_name = p_name;
        this.address = address;
        this.c_number = c_number;
        this.gender = gender;
        this.d_id = d_id;
        this.appointment_datetime = appointment_datetime;
        this.status = status;
    }

    // Getter and Setter - appointment_id
    public int getAppointment_id() {
        return appointment_id;
    }

    public void setAppointment_id(int appointment_id) {
        this.appointment_id = appointment_id;
    }

    // Getter and Setter - appointment_number
    public String getAppointment_number() {
        return appointment_number;
    }

    public void setAppointment_number(String appointment_number) {
        this.appointment_number = appointment_number;
    }

    // Getter and Setter - p_id
    public Integer getP_id() {
        return p_id;
    }

    public void setP_id(Integer p_id) {
        this.p_id = p_id;
    }

    // Getter and Setter - p_name
    public String getP_name() {
        return p_name;
    }

    public void setP_name(String p_name) {
        this.p_name = p_name;
    }

    // Getter and Setter - address
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    // Getter and Setter - c_number
    public String getC_number() {
        return c_number;
    }

    public void setC_number(String c_number) {
        this.c_number = c_number;
    }

    // Getter and Setter - gender
    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    // Getter and Setter - d_id
    public int getD_id() {
        return d_id;
    }

    public void setD_id(int d_id) {
        this.d_id = d_id;
    }

    // Getter and Setter - appointment_datetime
    public Timestamp getAppointment_datetime() {
        return appointment_datetime;
    }

    public void setAppointment_datetime(Timestamp appointment_datetime) {
        this.appointment_datetime = appointment_datetime;
    }

    // Getter and Setter - status
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}