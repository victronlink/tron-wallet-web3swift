
import Foundation
import keccak

extension Data {
    /// - Returns: keccak256 hash of data
    public func keccak256() -> Data {
        var result = Data(count: 32)
        result.withUnsafeMutableBytes { (outPtr: UnsafeMutablePointer<UInt8>) in
            self.withUnsafeBytes { (inPtr: UnsafePointer<UInt8>) in
                keccak_256(outPtr, 32, inPtr, self.count)
            }
        }
        return result
    }
}
