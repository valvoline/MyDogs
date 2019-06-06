//
//  DogDetails.swift
//  SwiftUITest2
//
//  Created by Costantino Pistagna on 06/06/2019.
//  Copyright © 2019 sofapps.it All rights reserved.
//

import SwiftUI

struct DogDetailsView: View {
	@State var dataSource: Dog
	
	var body: some View {
		NavigationView {
			VStack {
				Image(uiImage: dataSource.thumb.sizeImage(to: 256))
					.clipShape(Circle())
					.overlay(Circle().stroke(Color.gray, lineWidth: 4).shadow(radius: 2).offset(CGSize(width: 0, height: 2)))
				Text(dataSource.name)
					.font(.title)
				Text(dataSource.location)
					.font(.body)
					.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
				Text(dataSource.description)
					.font(.footnote)
				Slider(value: $dataSource.rating, from: 0.0, through: 10.0, by: 1.0).padding(EdgeInsets(top: 32, leading: 32, bottom: 32, trailing: 32))
				Spacer()
			}
			}.navigationBarItems(trailing: Button(action: {
				self.dataSource.favorited = !self.dataSource.favorited
			}, label: {
				Image(systemName: (self.dataSource.favorited) ? "star.fill" : "star")
					.imageScale(Image.Scale.large)
			}))
	}
}

