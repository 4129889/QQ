package com.tha103.newview.discount.model;

import java.util.List;

public interface DiscountDAO {
	
	public int insert(DiscountVO DiscountVO);
    public int update(DiscountVO DiscountVO);
    public int delete(Integer discountNO);
    public DiscountVO findByPrimaryKey(Integer discountNO);
    public List<DiscountVO> getAll();
	public DiscountVO getDisAmountBy(String discountCode);
    
//	萬用複合查詢(傳入參數型態Map)(回傳List)
//  public List<DiscountVO> getAll(Map<String, String[]> map);
    
    //for Publisher Backstage get discount List
    public List<DiscountVO> getDiscountByPubID(Integer pubID);
}
