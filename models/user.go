package models

import "gopkg.in/mgo.v2/bson"

type (  
    // User represents the structure of our resource
    User struct {
        Id     	  bson.ObjectId `json:"id"				bson:"_id"`
        Email			string  `json:"email"			bson:"email"`
        Pass			string	`json:"pass"			bson:"pass"`

        Name   			string  `json:"name"			bson:"name"`
        Contact_Pic		string  `json:"contact_pic" 	bson:"contact_pic"`
        Place_We_Met	string  `json:"place_we_met" 	bson:"place_we_met"`
        Phone   		int		`json:"phone"			bson:"phone"`
        Address			string	`json:"address"			bson:"address"`

        Occupation		string	`json:"occupation"		bson:"occupation"`
        Company			string	`json:"company"			bson:"company"`
        Company_Logo	string	`json:"company_logo"	bson:"company_logo"`
        Start_Date		string	`json:"start_date"		bson:"start_date"`
        Finish_Date		string	`json:"finish_date"		bson:"finish_date"`

        School_Name		string	`json:"school_name"		bson:"school_name"`
        School_Logo		string	`json:"school_logo"		bson:"school_logo"`
        Degree			string	`json:"degree"			bson:"degree"`
    }
)