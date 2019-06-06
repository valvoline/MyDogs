//
//  DogCard.swift
//  SwiftUITest2
//
//  Created by Costantino Pistagna on 06/06/2019.
//  Copyright © 2019 sofapps.it All rights reserved.
//

import SwiftUI
import Combine

extension UIImage {
	func sizeImage(to size: Int) -> UIImage {
		guard
			let image = self.cgImage,
			let colorSpace = image.colorSpace,
			let context = CGContext(
				data: nil,
				width: size, height: size,
				bitsPerComponent: image.bitsPerComponent,
				bytesPerRow: image.bytesPerRow,
				space: colorSpace,
				bitmapInfo: image.bitmapInfo.rawValue)
			else {
				fatalError("Couldn't create graphics context.")
		}
		context.interpolationQuality = .high
		context.draw(image, in: CGRect(x: 0, y: 0, width: size, height: size))
		
		if let sizedImage = context.makeImage() {
			return UIImage(cgImage: sizedImage)
		} else {
			fatalError("Couldn't resize image.")
		}
	}
}

struct DogCard: View {
	@State var dataSource: Dog
	
	var body: some View {
		NavigationButton(destination: DogDetailsView(dataSource: dataSource)) {
			HStack {
				Image(uiImage: dataSource.thumb)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.clipShape(Circle())
					.overlay(Circle().stroke(Color.gray, lineWidth: 4))
					.imageScale(Image.Scale.small)
				VStack(alignment: .leading, spacing: 0) {
					Text(dataSource.name)
						.lineLimit(1)
						.font(.title)
					Text(dataSource.location)
						.lineLimit(1)
						.font(.body)
					Text(dataSource.description)
						.lineLimit(1)
						.font(.caption)
				}
				Spacer()
			}.padding(EdgeInsets.init(top: 8, leading: 8, bottom: 8, trailing: 8))
		}
	}
}
