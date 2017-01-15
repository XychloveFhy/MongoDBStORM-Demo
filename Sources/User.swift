//
//  User.swift
//  MongoDBStORM-Demo
//
//  Created by Jonathan Guthrie on 2017-01-11.
//
//

import StORM
import MongoDBStORM

class User: MongoDBStORM {

	// Set some properties for the object
	// These properties are reflected in the database table
	// NOTE: First param in class should be the ID.
	var id				: String = ""
	var firstname		: String = ""
	var lastname		: String = ""
	var email			: String = ""


	// The name of the database table
	override init() {
		super.init()
		_collection = "users_demo"
	}


	// The mapping that translates the database info back to the object
	// This is where you would do any validation or transformation as needed
	override func to(_ this: StORMRow) {
		id				= this.data["_id"] as? String			?? ""
		firstname		= this.data["firstname"] as? String		?? ""
		lastname		= this.data["lastname"] as? String		?? ""
		email			= this.data["email"] as? String			?? ""
	}

	// A simple iteration.
	// Unfortunately necessary due to Swift's introspection limitations
	func rows() -> [User] {
		var rows = [User]()
		for i in 0..<self.results.rows.count {
			let row = User()
			row.to(self.results.rows[i])
			rows.append(row)
		}
		return rows
	}
}
