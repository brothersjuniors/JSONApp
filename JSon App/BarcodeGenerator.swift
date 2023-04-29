//
//  BarcodeGenerator.swift
//  JSon App
//
//  Created by 近江伸一 on 2023/04/28.
//

import UIKit
import ZXingObjC
class BarcodeGenerator: UIViewController {
    static public func generateBarCode(from string: String) -> UIImage? {
        do {
            let writer = ZXMultiFormatWriter()
            let hints = ZXEncodeHints() as ZXEncodeHints
            let result = try writer.encode(string, format:  kBarcodeFormatEan13, width: 280, height: 50, hints: hints)
            if let imageRef = ZXImage.init(matrix: result) {
                if let image = imageRef.cgimage {
                    return UIImage.init(cgImage: image)
                }
            }
        }
        catch {
            print(error)
        }
        return nil
    }
}
