import { getHotSearchList } from '../api'
import { SearchKey } from './SearchKey'

@Component
struct SearchResult {
  @State hotSearchList: string[] = [];

  async aboutToAppear() {
    this.hotSearchList = await getHotSearchList();
  }

  build() {
    Column() {
      Column() {
        SearchKey({
          title: '热门搜索',
          labels: this.hotSearchList
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .border({
      color: '#f3f3f3',
      width: {
        top: 1
      }
    })
  }
}

export { SearchResult }