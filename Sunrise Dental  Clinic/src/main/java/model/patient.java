package model;

public class patient {
    int p_id;
    String p_name;
    String address;
    String c_number;
    String gender;
    java.sql.Timestamp register_datetime;
    String status;

    public patient() {
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

    public java.sql.Timestamp getRegister_datetime() {
        return register_datetime;
    }

    public void setRegister_datetime(java.sql.Timestamp register_datetime) {
        this.register_datetime = register_datetime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}