@Component
struct BookSearch {
  build() {
    Row({ space: 10 }) {
      Search({ placeholder: '搜索图书名称' })
        .height(36)
        .layoutWeight(1)
        .placeholderColor('#aaa')
        .searchIcon({
          color: '#aaa'
        })

      Button('取消')
        .backgroundColor(Color.White)
        .fontColor('rgba(0,0,0,0.5)')
        .fontSize(16)
        .height(36)
        .border({
          color: '#aaa',
          width: 1
        })
    }
    .width('100%')
    .height(60)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}

export { BookSearch }