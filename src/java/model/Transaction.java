package model;

import lombok.Data;
import java.util.Date;

@Data
public class Transaction {
    private int transactionId;
    private String transactionType;
    private int riceId;
    private int customerId;
    private int quantity;
    private Date transactionDate;
    private boolean porterService;
    private double totalAmount;
}
