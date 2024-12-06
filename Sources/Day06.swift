import Algorithms

struct Day06: AdventDay {
  var data: String

  struct Position: Hashable, Sendable {
    var point: Point
    var direction: Direction

    func nextPoint() -> Point {
      point.neighbor(direction: direction)
    }

    mutating func nextDirection() -> Direction {
      switch direction {
      case .top: .right
      case .right: .bottom
      case .bottom: .left
      case .left: .top
      default: .top
      }
    }
  }

  private var input: (maps: [Point: String], current: Point) {
    let lines = data.components(separatedBy: .newlines)
    var r: [Point: String] = [:]
    var current = Point(x: 0, y: 0)
    for (y, line) in lines.enumerated() {
      for (x, char) in line.enumerated() {
        r[Point(x: x, y: y)] = String(char)
        if char == "^" {
          current = Point(x: x, y: y)
        }
      }
    }
    return (r, current)
  }

  private func calPoints(
    points: [Point: String],
    startPoint: Point
  ) -> [Point] {
    var current = Position(point: startPoint, direction: .top)
    var pastPoints: [Point] = []
    while true {
      let next = current.nextPoint()
      if !points.keys.contains(next) {
        break
      }
      if points[next] == "#" {
        current.direction = current.nextDirection()
      } else {
        current.point = next
        pastPoints.append(next)
      }
    }
    return pastPoints
  }

  func part1() -> Any {
    let (points, initial) = input
    return Set(calPoints(points: points, startPoint: initial)).count
  }

  private func isLoop(
    points: [Point: String],
    startPoint: Point
  ) -> Bool {
    var current = Position(point: startPoint, direction: .top)
    var pastPoints: Set<Position> = []
    while true {
      let next = current.nextPoint()
      if !points.keys.contains(next) {
        break
      }

      if pastPoints.contains(current) {
        return true
      }
      pastPoints.insert(current)

      if points[next] == "#" {
        current.direction = current.nextDirection()
      } else {
        current.point = next
      }
    }
    return false
  }

  func part2() -> Any {
    var (points, initial) = input

    var count = 0

    let defaultPoints = Set(
      calPoints(points: points, startPoint: initial)
        .flatMap { point in
          let neighbors: [Direction] = [
            .top, .right, .bottom, .left
          ]
          return neighbors.map { point.neighbor(direction: $0) }
        }
    )

    var lastPoint: Point?

    for (point, char) in points {
      if char != "#" && point != initial && defaultPoints.contains(point) {
        if let lastPoint {
          points[lastPoint] = ""
        }
        lastPoint = point
        points[point] = "#"
        if isLoop(points: points, startPoint: initial) {
          count += 1
        }
      }
    }
    return count
  }
}
