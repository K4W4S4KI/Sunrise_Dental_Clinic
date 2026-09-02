package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class bill {

    private int appointment_id;
    private String appointment_number;
    private int p_id;
    private String p_name;
    private String address;
    private String c_number;
    private String gender;
    private int d_id;
    private String dentist_name;
    private Timestamp appointment_datetime;
    private String status;
    private BigDecimal treatment_total;
    private BigDecimal consultation_fee;
    private BigDecimal grand_total;

    public bill() {
    }

    public int getAppointment_id() {
        return appointment_id;
    }

    public void setAppointment_id(int appointment_id) {
        this.appointment_id = appointment_id;
    }

    public String getAppointment_number() {
        return appointment_number;
    }

    public void setAppointment_number(String appointment_number) {
        this.appointment_number = appointment_number;
    }

    public int getP_id() {
        return p_id;
    }

    public void setP_id(int p_id) {
        this.p_id = p_id;
    }

    public String getP_name() {
        return p_name;
    }

    public void setP_name(String p_name) {
        this.p_name = p_name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getC_number() {
        return c_number;
    }

    public void setC_number(String c_number) {
        this.c_number = c_number;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getD_id() {
        return d_id;
    }

    public void setD_id(int d_id) {
        this.d_id = d_id;
    }

    public String getDentist_name() {
        return dentist_name;
    }

    public void setDentist_name(String dentist_name) {
        this.dentist_name = dentist_name;
    }

    public Timestamp getAppointment_datetime() {
        return appointment_datetime;
    }

    public void setAppointment_datetime(Timestamp appointment_datetime) {
        this.appointment_datetime = appointment_datetime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getTreatment_total() {
        return treatment_total;
    }

    public void setTreatment_total(BigDecimal treatment_total) {
        this.treatment_total = treatment_total;
    }

    public BigDecimal getConsultation_fee() {
        return consultation_fee;
    }

    public void setConsultation_fee(BigDecimal consultation_fee) {
        this.consultation_fee = consultation_fee;
    }

    public BigDecimal getGrand_total() {
        return grand_total;
    }

    public void setGrand_total(BigDecimal grand_total) {
        this.grand_total = grand_total;
    }
}