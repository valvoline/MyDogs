//
//  DogList.swift
//  MyDogs
//
//  Created by Costantino Pistagna on 08/06/2019.
//  Copyright © 2019 sofapps. All rights reserved.
//

import SwiftUI
import Combine

class DogList : BindableObject {
	let didChange = PassthroughSubject<DogList, Never>()

	var items: [Dog] {
		didSet {
			didChange.send(self)
		}
	}

	var favorites: [Dog] {
		didSet {
			didChange.send(self)
		}
	}

	init(items: [Dog] = []) {
		self.items = items
		self.favorites = []
	}

	func moveToFavorites(_ dog: Dog) {
		guard favorites.contains(where: { (aDog) -> Bool in
			return aDog.id == dog.id
		}) == false else { return }
		
		items.removeAll { (aDog) -> Bool in
			return aDog.id == dog.id
		}
		favorites.insert(dog, at: 0)
	}
	
	func removeFromFavorites(_ dog: Dog) {
		guard favorites.contains(where: { (aDog) -> Bool in
			return aDog.id == dog.id
		}) else { return }

		favorites.removeAll { (aDog) -> Bool in
			return aDog.id == dog.id
		}
		items.append(dog)
	}
}
