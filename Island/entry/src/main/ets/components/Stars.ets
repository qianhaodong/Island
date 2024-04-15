@Component
struct Stars {
  build() {
    Row() {
      Image(true ? $r('app.media.love_active_icon') : $r('app.media.love_icon'))
        .width(16)
        .height(14)
      Text('1314')
        .fontSize(10)
        .fontColor('#a1a1a1')
        .offset({
          y: -6,
          x: 1
        })
    }
  }
}

export { Stars }