import Foundation

struct Point: Hashable {
  let x, y: Int

  func neighbor(direction: Direction, steps: Int = 1) -> Point {
    switch direction {
    case .bottom:
      return Point(x: x, y: y + steps)
    case .bottomLeft:
      return Point(x: x - steps, y: y + steps)
    case .bottomRight:
      return Point(x: x + steps, y: y + steps)
    case .top:
      return Point(x: x, y: y - steps)
    case .topLeft:
      return Point(x: x - steps, y: y - steps)
    case .topRight:
      return Point(x: x + steps, y: y - steps)
    case .left:
      return Point(x: x - steps, y: y)
    case .right:
      return Point(x: x + steps, y: y)
    }
  }
}
