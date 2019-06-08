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
	var items: [Dog] {
		didSet {
			didChange.send(self)
		}
	}
	
	init(items: [Dog] = []) {
		self.items = items
	}
	
	let didChange = PassthroughSubject<DogList, Never>()
}
