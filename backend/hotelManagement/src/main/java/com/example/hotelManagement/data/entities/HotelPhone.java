package com.example.hotelManagement.data.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "HotelPhone")
public class HotelPhone {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "hotel_id", nullable = false)
    private Hotel hotel;

    @Column(nullable = false, length = 10)
    private String phoneNumber;

    public HotelPhone(Integer id, Hotel hotel, String phoneNumber) {
        this.id = id;
        this.hotel = hotel;
        this.phoneNumber = phoneNumber;
    }

    public HotelPhone() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Hotel getHotel() {
        return hotel;
    }

    public void setHotel(Hotel hotel) {
        this.hotel = hotel;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}
