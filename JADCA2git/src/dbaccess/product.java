package dbaccess;

public class product {
	private String productId;
	private String productName;
	private String description;
	private  String detailDescription;
	private  String costPrice;
	private  String retailPrice;
	private  String discountPrice;
	private  String stockQuantity;
	private  String categoryName;
	private  String imageLocation;
	
	public product(String productId,String productName,String description,String detailDescription,String costPrice,String retailPrice,String discountPrice,String stockQuantity,String categoryName,String imageLocation) {
		this.productId=productId;
		this.productName=productName;
		this.description=description;
		this.detailDescription=detailDescription;
		this.costPrice=costPrice;
		this.retailPrice=retailPrice;
		this.discountPrice=discountPrice;
		this.stockQuantity=stockQuantity;
		this.categoryName=categoryName;
		this.imageLocation=imageLocation;
	}
	
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getDetailDescription() {
		return detailDescription;
	}
	public void setDetailDescription(String detailDescription) {
		this.detailDescription = detailDescription;
	}
	public String getCostPrice() {
		return costPrice;
	}
	public void setCostPrice(String costPrice) {
		this.costPrice = costPrice;
	}
	public String getRetailPrice() {
		return retailPrice;
	}
	public void setRetailPrice(String retailPrice) {
		this.retailPrice = retailPrice;
	}
	public String getDiscountPrice() {
		return discountPrice;
	}
	public void setDiscountPrice(String discountPrice) {
		this.discountPrice = discountPrice;
	}
	public String getStockQuantity() {
		return stockQuantity;
	}
	public void setStockQuantity(String stockQuantity) {
		this.stockQuantity = stockQuantity;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getImageLocation() {
		return imageLocation;
	}
	public void setImageLocation(String imageLocation) {
		this.imageLocation = imageLocation;
	}	
}

