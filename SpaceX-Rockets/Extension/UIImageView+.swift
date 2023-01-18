//
//  UIImage+.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 19.11.2022.
//

import UIKit

extension UIImageView {
    private static let cache = NSCache<NSString, UIImage>()
    private var cache: NSCache<NSString, UIImage> { Self.cache }
    
    public func loadAsync(from urlString: String, placeholder: UIImage?) {
        if let cachedImage = cache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                self.image = placeholder
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                if let image = UIImage(data: data!) {
                    self?.cache.setObject(image, forKey: urlString as NSString)
                    self?.image = image
                }
            }
        }.resume()
    }
}
