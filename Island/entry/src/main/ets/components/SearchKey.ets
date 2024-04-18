@Component
struct SearchKey {
  @Require @Prop title: string = '';
  @Prop labels: string[] = [];

  labelClick: (label: string) => void = () => {};

  build() {
    Column({ space: 15 }) {
      Row({ space: 10 }) {
        Row()
          .width(4)
          .height(14)
          .backgroundColor(Color.Black)
        Text(this.title)
      }

      Flex({
        wrap: FlexWrap.Wrap,
      }) {
        ForEach(this.labels, (item: string) => {
          Text(item)
            .fontSize(14)
            .fontColor('#666')
            .backgroundColor('#f7f7f7')
            .borderRadius(2)
            .padding({ top: 5, right: 10, bottom: 5, left: 10 })
            .margin({ right: 10, bottom: 10 })
            .onClick(() => {
              this.labelClick(item);
            })
        })
      }
      .padding({ left: 14 })
    }
    .width('100%')
    .padding(15)
    .alignItems(HorizontalAlign.Start)
  }
}

export { SearchKey }