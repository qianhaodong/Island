export interface TabDataType {
  title: string
  name: string
  icon: ResourceStr
  iconActive: ResourceStr
}

export interface ClassicType {
  id: number
  title: string
  content: string
  index: number
  image: string
  fav_nums: number
  pubdata: string
  type: number
  url?: string
}

export interface BookItemType {
  id: number
  title: string
  author: string
  image: string
  fav_nums: number
  like_status: number
}