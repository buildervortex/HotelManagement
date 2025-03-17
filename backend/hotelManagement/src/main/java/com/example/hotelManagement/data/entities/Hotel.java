package com.example.hotelManagement.data.entities;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "Hotel")
public class Hotel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private double longitude;

    @Column(nullable = false)
    private double latitude;

    @OneToMany(mappedBy = "hotel", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<HotelPhone> phoneNumbers;

    public Hotel() {
    }

    public Hotel(Integer id, String name, String address, double longitude, double latitude, List<HotelPhone> phoneNumbers) {
        this.id = id;
        this.name = name;
        this.address = address;
        this.longitude = longitude;
        this.latitude = latitude;
        this.phoneNumbers = phoneNumbers;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public List<HotelPhone> getPhoneNumbers() {
        return phoneNumbers;
    }

    public void setPhoneNumbers(List<HotelPhone> phoneNumbers) {
        this.phoneNumbers = phoneNumbers;
    }
}
