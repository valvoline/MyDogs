//
//  Dog.swift
//  SwiftUITest2
//
//  Created by Costantino Pistagna on 06/06/2019.
//  Copyright © 2019 sofapps.it All rights reserved.
//

import SwiftUI
import Combine

class Dog : BindableObject, Identifiable {
	let didChange = PassthroughSubject<Dog, Never>()
	
	var id = UUID()
	var name: String
	var location: String
	var description: String
	var favorited: Bool = false {
		didSet {
			didChange.send(self)
		}
	}
	var thumb: UIImage {
		didSet {
			didChange.send(self)
		}
	}
	var rating: Float = 10.0 //all dogs are good, by default
	private var task: URLSessionDataTask?
	private var subTask: URLSessionDataTask?
	
	init(name: String, location: String, description: String, imageURL:String = "https://dog.ceo/api/breeds/image/random") {
		self.name = name
		self.location = location
		self.description = description
		self.thumb = UIImage(named: "dogPlaceHolder")!
		loadRandomThumb(with: URL(string: imageURL))
	}
	
	deinit {
		task?.cancel()
		subTask?.cancel()
	}
	
	private func loadRandomThumb(with url:URL?) {
		guard let url = url else { return }
		
		task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
			if let data = data {
				do {
					if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any],
						let imageString = jsonResponse["message"] as? String,
						let imageURL = URL(string: imageString)
					{
						self.subTask = URLSession.shared.dataTask(with: imageURL, completionHandler:  { data, _, _ in
							if let data = data {
								DispatchQueue.main.async {
									self.thumb = UIImage(data: data) ?? UIImage(named: "dogPlaceHolder")!
								}
							}
						})
						self.subTask?.resume()
					}
				} catch {
					//catch something here
				}
			}
		})
		task?.resume()
	}
	
}
