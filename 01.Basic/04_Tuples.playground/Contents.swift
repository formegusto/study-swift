import UIKit

// Tuples (n짝, n쌍)
// 화면 Title, 화면 Image
var topTitle = ("메인화면", "mainIcon.png")
// topTitle: (String, String)

print(topTitle.0) // 메인화면
print(topTitle.1) // mainIcon.png

// http status code
var httpOk = (200, "success")
var httpError = (404, "Page Not Found")
print("status code:", httpError.0)
print("msg:", httpError.1)

var httpUnauth = (statusCode: 401, description: "Unauthorized")
// httpUnauth: (statusCode: Int, description: String)
print(httpUnauth.statusCode)
print(httpUnauth.description)
