//
//  TXSign.swift
//  JAChatAndSocialSDKExample
//
//  Created by 张嘉诚 on 2024/3/4.
//

import Foundation
import CommonCrypto
import zlib

class GenerateTestUserSig {

    static func genTestUserSig(identifier: String) -> String {
        let current = CFAbsoluteTimeGetCurrent() + kCFAbsoluteTimeIntervalSince1970
        let TLSTime = Int(floor(current))
        var obj: [String: Any] = ["TLS.ver": "2.0",
                                  "TLS.identifier": identifier,
                                  "TLS.sdkappid": 1400482233,
                                  "TLS.expire": 100000,
                                  "TLS.time": TLSTime]
        var stringToSign = ""
        let keyOrder = ["TLS.identifier",
                        "TLS.sdkappid",
                        "TLS.time",
                        "TLS.expire"]
        for key in keyOrder {
            stringToSign += "\(key):\(obj[key]!)\n"
        }
        print(stringToSign)
        let sig = hmac(plainText: stringToSign)
        obj["TLS.sig"] = sig
        print("sig: \(sig)")
        do {
            let jsonToZipData = try JSONSerialization.data(withJSONObject: obj, options: [])
            let zipsrc = [UInt8](jsonToZipData)
            let srcLen = UInt32(jsonToZipData.count)
            let upperBound = compressBound(uLong(srcLen))
            var dest = [UInt8](repeating: 0, count: Int(upperBound))
            var destLen = upperBound
            let ret = compress2(&dest, &destLen, zipsrc, uLong(srcLen), Z_BEST_SPEED)
            if ret != Z_OK {
                print("[Error] Compress Error \(ret), upper bound: \(upperBound)")
                return ""
            }
            let result = base64URL(data: Data(bytes: dest, count: Int(destLen)))
            return result
        } catch {
            print("[Error] json serialization failed: \(error)")
            return ""
        }
    }

    static func hmac(plainText: String) -> String {
        let cKey = ("0f9807382f948c8a155d97188ba990acce38f0bbb31d6913076a280e70c34b76" as NSString).utf8String
        let cData = (plainText as NSString).utf8String
        var cHMAC = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), cKey, strlen(cKey), cData, strlen(cData), &cHMAC)
        let HMACData = Data(bytes: cHMAC, count: Int(CC_SHA256_DIGEST_LENGTH))
        return HMACData.base64EncodedString(options: [])
    }

    static func base64URL(data: Data) -> String {
        var result = data.base64EncodedString(options: [])
        result = result.replacingOccurrences(of: "+", with: "*")
        result = result.replacingOccurrences(of: "/", with: "-")
        result = result.replacingOccurrences(of: "=", with: "_")
        return result
    }
}
