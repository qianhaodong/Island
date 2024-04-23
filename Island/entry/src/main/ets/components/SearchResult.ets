import { router, SwipeRefresher } from '@kit.ArkUI';
import { getHotSearchList, getSearchResult } from '../api/book'
import { BookItemType, DataModel } from '../models';
import { StoreManager } from '../utils/store';
import { SearchKey } from './SearchKey'

@Component
struct SearchResult {
  @Link @Watch('listenQueryChange') query: string;
  @State hotSearchList: string[] = [];
  @State historySearchList: string[] = [];
  @State searchKeyShow: boolean = true;
  @State searchList: BookItemType[] = [];
  @State isLoading: boolean = false;
  @State isEmpty: boolean = false;

  aboutToAppear() {
    // 获取热门搜索
    getHotSearchList().then((res: string[]) => {
      this.hotSearchList = res;
    });

    // 获取搜索历史
    this.historySearchList = StoreManager.getHistorySearchList();
  }

  // 监听query变化，查询数据
  async listenQueryChange() {
    if (this.query === '') {
      this.searchKeyShow = true;
      return;
    }

    this.searchKeyShow = false;
    this.isLoading = true;
    this.isEmpty = false;

    // 调用搜索接口，获取搜索结果
    this.searchList = await getSearchResult(this.query);
    this.isLoading = false;

    if (!this.searchList.length) {
      this.isEmpty = true;
    }

    // 保存到历史搜索
    this.saveHistorySearchList(this.query);
  }

  saveHistorySearchList(label: string) {
    // 判断当前搜索key是否存在
    const cIndex = this.historySearchList.findIndex((item) => item === label);
    if (cIndex !== -1) {
      // 存在，则移除
      this.historySearchList.splice(cIndex, 1)
    }

    // 添加到首位
    this.historySearchList.unshift(label);

    // 保存到首选项
    StoreManager.setHistorySearchList(this.historySearchList);
  }

  build() {
    Column() {
      if (this.searchKeyShow) {
        Column() {
          if (this.historySearchList.length) {
            SearchKey({
              title: '历史搜索',
              labels: this.historySearchList,
              labelClick: (label) => {
                this.query = label;
              }
            })
          }

          SearchKey({
            title: '热门搜索',
            labels: this.hotSearchList,
            labelClick: (label) => {
              this.query = label;
            }
          })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      } else {
        if (this.isLoading) {
          Column() {
            SwipeRefresher({
              content: '',
              isLoading: this.isLoading,
            })
          }
          .width('100%')
          .height('100%')
        } else {
          if (this.isEmpty) {
            Column() {
              Text('暂无搜索内容~')
                .fontSize(18)
                .fontColor('#999')
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          }

          if (this.searchList.length) {
            Column() {
              ForEach(this.searchList, (item: BookItemType, index) => {
                Row({ space: 10 }) {
                  Image(item.image)
                    .width(42)
                    .height(56)
                    .objectFit(ImageFit.Fill)
                  Column({ space: 8 }) {
                    Text(item.title)
                      .fontSize(16)
                      .fontColor('#1f1f1f')
                    Text(item.author.toString())
                      .fontColor('#bbb')
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .padding({ top: 16, bottom: 16 })
                .border({
                  color: '#f3f3f3',
                  width: {
                    bottom: index === this.searchList.length - 1 ? 0 : 1
                  }
                })
                .onClick(() => {
                  const params: DataModel = {
                    id: item.id
                  };
                  router.pushUrl({
                    url: 'pages/BookDetails',
                    params
                  })
                })
              })
            }
            .width('100%')
            .padding({ left: 20, right: 20 })
          }
        }
      }
    }
    .border({
      color: '#f3f3f3',
      width: {
        top: 1
      }
    })
    .backgroundColor(Color.White)
  }
}

export { SearchResult }