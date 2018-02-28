//: # Lossless Compression

import UIKit
import Compression

let originalImage = UIImage(named: "time.jpg")!
let data = UIImageJPEGRepresentation(originalImage, 1)!
//: Size before compression
let sourceSize = data.count

let compressedBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: sourceSize)

var compressedSize: Int = 0

data.withUnsafeBytes { (sourceBuffer: UnsafePointer<UInt8>) in
    
    compressedSize = compression_encode_buffer(compressedBuffer, sourceSize, sourceBuffer, sourceSize, nil, COMPRESSION_LZFSE)
    
    //: Size after compression
    compressedSize
}

var uncompressedBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: sourceSize)

let uncompressedSize = compression_decode_buffer(uncompressedBuffer, sourceSize, compressedBuffer, compressedSize, nil, COMPRESSION_LZFSE)

//: Size after un-compression
uncompressedSize

let unarchived = Data(bytes: uncompressedBuffer, count: uncompressedSize)
let unarchivedImage = UIImage(data: unarchived, scale:1.0)

