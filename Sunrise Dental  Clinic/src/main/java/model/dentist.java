package model;

public class dentist {

    private int dentist_id;
    private String dentist_name;
    private String specialization;
    private String contact_number;
    private String status;

    // Default Constructor
    public dentist() {
    }

    // Parameterized Constructor
    public dentist(int dentist_id, String dentist_name, String specialization,
                   String contact_number, String status) {
        this.dentist_id = dentist_id;
        this.dentist_name = dentist_name;
        this.specialization = specialization;
        this.contact_number = contact_number;
        this.status = status;
    }

    // Constructor without ID
    public dentist(String dentist_name, String specialization,
                   String contact_number, String status) {
        this.dentist_name = dentist_name;
        this.specialization = specialization;
        this.contact_number = contact_number;
        this.status = status;
    }

    // Getter and Setter for dentist_id
    public int getDentist_id() {
        return dentist_id;
    }

    public void setDentist_id(int dentist_id) {
        this.dentist_id = dentist_id;
    }

    // Getter and Setter for dentist_name
    public String getDentist_name() {
        return dentist_name;
    }

    public void setDentist_name(String dentist_name) {
        this.dentist_name = dentist_name;
    }

    // Getter and Setter for specialization
    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    // Getter and Setter for contact_number
    public String getContact_number() {
        return contact_number;
    }

    public void setContact_number(String contact_number) {
        this.contact_number = contact_number;
    }

    // Getter and Setter for status
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}