@Component
struct BookSearch {
  @Link query: string;
  @Link searchFocus: boolean;

  @State searchPlaceholder: string = '搜索图书名称';
  controller: SearchController = new SearchController()

  build() {
    Row({ space: 10 }) {
      Stack({ alignContent: Alignment.End }) {
        Search({
          value: this.query,
          placeholder: this.searchPlaceholder,
          controller: this.controller,
        })
          .height(36)
          .margin({ right: this.searchFocus ? 80 : 0 })
          .placeholderColor('#aaa')
          .searchIcon({
            color: '#aaa'
          })
          .focusOnTouch(true)
          .onChange((value: string) => {
            if (value === '') {
              this.query = value;
            }
          })
          .onFocus(() => {
            this.searchPlaceholder = '搜索图书名称';
            this.searchFocus = true;
          })
          .onBlur(() => {
            this.searchPlaceholder = '搜索图书名称';
          })
          .onSubmit((value: string) => {
            if (value === '') {
              this.searchPlaceholder = '请输入搜索内容';
              return;
            }

            this.query = value;
          })
          .zIndex(2)
          .backgroundColor('#f5f5f5')

        Button('取消')
          .backgroundColor(Color.White)
          .fontColor('rgba(0,0,0,0.5)')
          .fontSize(16)
          .height(36)
          .border({
            color: '#aaa',
            width: 1
          })
          .focusOnTouch(true)
          .onClick(() => {
            this.searchFocus = false;
            this.query = '';
            this.controller.stopEditing()
          })
          .zIndex(1)
      }
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