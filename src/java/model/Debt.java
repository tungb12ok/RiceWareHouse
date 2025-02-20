package model;

import lombok.Data;
import java.util.Date;

@Data
public class Debt {
    private int debtId;
    private int customerId;
    private String debtType;
    private double amount;
    private String note;
    private Date debtDate;
}
