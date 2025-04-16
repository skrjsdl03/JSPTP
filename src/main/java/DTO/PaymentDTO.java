package DTO;

public class PaymentDTO {
	private int pay_id;
	private String user_id;
	private String user_type;
	private String pay_status;
	private String paid_at;
	private String pay_trans_id;
	private String pay_appr_code;
	private String pay_card_com;
	private String pay_req_id;
	
	public PaymentDTO() {}

	public PaymentDTO(int pay_id, String user_id, String user_type, String pay_status, String paid_at, String pay_trans_id,
			String pay_appr_code, String pay_card_com, String pay_req_id) {
		super();
		this.pay_id = pay_id;
		this.user_id = user_id;
		this.user_type = user_type;
		this.pay_status = pay_status;
		this.paid_at = paid_at;
		this.pay_trans_id = pay_trans_id;
		this.pay_appr_code = pay_appr_code;
		this.pay_card_com = pay_card_com;
		this.pay_req_id = pay_req_id;
	}

	public int getPay_id() {
		return pay_id;
	}

	public void setPay_id(int pay_id) {
		this.pay_id = pay_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getPay_status() {
		return pay_status;
	}

	public void setPay_status(String pay_status) {
		this.pay_status = pay_status;
	}

	public String getPaid_at() {
		return paid_at;
	}

	public void setPaid_at(String paid_at) {
		this.paid_at = paid_at;
	}

	public String getPay_trans_id() {
		return pay_trans_id;
	}

	public void setPay_trans_id(String pay_trans_id) {
		this.pay_trans_id = pay_trans_id;
	}

	public String getPay_appr_code() {
		return pay_appr_code;
	}

	public void setPay_appr_code(String pay_appr_code) {
		this.pay_appr_code = pay_appr_code;
	}

	public String getPay_card_com() {
		return pay_card_com;
	}

	public void setPay_card_com(String pay_card_com) {
		this.pay_card_com = pay_card_com;
	}

	public String getPay_req_id() {
		return pay_req_id;
	}

	public void setPay_req_id(String pay_req_id) {
		this.pay_req_id = pay_req_id;
	}
	
	
}
