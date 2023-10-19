package com.tha103.newview.cityaddress.model;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.gson.annotations.Expose;
import com.tha103.newview.act.model.ActVO;

@Entity
@Table(name = "city")
@NamedQuery(name = "getAllCityAddress", query = "from CityAddress where cityAddressID > :cityAddressID order by cityAddressID desc")
public class CityAddress {
	@Expose
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "cityAddressID", updatable = false)
	private Integer cityAddressID;
	@Expose
	@Column(name = "cityName")
	private String cityName;
	@Expose
	@OneToMany(mappedBy = "city", cascade=CascadeType.ALL)
	@JsonIgnore
	private Set<ActVO> acts;
	
	public Integer getActAdressID() {
		return cityAddressID;
	}
	public void setActAdressID(Integer actAdressID) {
		this.cityAddressID = actAdressID;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public Set<ActVO> getActs() {
		return acts;
	}
	public void setActs(Set<ActVO> acts) {
		this.acts = acts;
	}
	@Override
	public String toString() {
		return "cityadress [actAddressID=" + cityAddressID + ", cityName=" + cityName + ", acts=" + acts + "]";
	}
	public CityAddress() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CityAddress(Integer actAddressID, String cityName, Set<ActVO> acts) {
		super();
		this.cityAddressID = actAddressID;
		this.cityName = cityName;
		this.acts = acts;
	}
	public boolean isEmpty() {
		// TODO Auto-generated method stub
		return false;
	}
	
	
	
	
}