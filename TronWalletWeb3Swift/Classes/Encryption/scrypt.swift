
import Foundation
import scrypt

public func scrypt(password: String, salt: Data, length: Int, N: Int, R: Int, P: Int) -> Data? {
    let passwordData = password.data
    var derivedKey = Data(count: length)
    let status = passwordData.withUnsafeBytes { (passPtr: UnsafePointer<UInt8>) -> Int32 in
        salt.withUnsafeBytes { (saltPtr: UnsafePointer<UInt8>) -> Int32 in
            derivedKey.withUnsafeMutableBytes { (outPtr: UnsafeMutablePointer<UInt8>) -> Int32 in
                crypto_scrypt(passPtr, passwordData.count, saltPtr, salt.count, UInt64(N), UInt32(R), UInt32(P), outPtr, derivedKey.count)
            }
        }
    }
    guard status == 0 else { return nil }
    return derivedKey
}
