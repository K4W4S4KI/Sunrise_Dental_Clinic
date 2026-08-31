package model;

import java.math.BigDecimal;

public class treatment {

    private int treatment_id;
    private String treatment_name;
    private BigDecimal treatment_priceLkr;
    private String status;

    // Default Constructor
    public treatment() {
    }

    // Parameterized Constructor
    public treatment(int treatment_id, String treatment_name,
                     BigDecimal treatment_priceLkr, String status) {
        this.treatment_id = treatment_id;
        this.treatment_name = treatment_name;
        this.treatment_priceLkr = treatment_priceLkr;
        this.status = status;
    }

    // Constructor without ID
    public treatment(String treatment_name,
                     BigDecimal treatment_priceLkr, String status) {
        this.treatment_name = treatment_name;
        this.treatment_priceLkr = treatment_priceLkr;
        this.status = status;
    }

    // Getter and Setter for treatment_id
    public int getTreatment_id() {
        return treatment_id;
    }

    public void setTreatment_id(int treatment_id) {
        this.treatment_id = treatment_id;
    }

    // Getter and Setter for treatment_name
    public String getTreatment_name() {
        return treatment_name;
    }

    public void setTreatment_name(String treatment_name) {
        this.treatment_name = treatment_name;
    }

    // Getter and Setter for treatment_priceLkr
    public BigDecimal getTreatment_priceLkr() {
        return treatment_priceLkr;
    }

    public void setTreatment_priceLkr(BigDecimal treatment_priceLkr) {
        this.treatment_priceLkr = treatment_priceLkr;
    }

    // Getter and Setter for status
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}