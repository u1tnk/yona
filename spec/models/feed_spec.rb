# == Schema Information
#
# Table name: feeds
#
#  id               :integer          not null, primary key
#  url              :string(255)      not null
#  title            :string(255)      not null
#  html_url         :string(255)      not null
#  kind             :string(255)      not null
#  creator          :string(255)
#  etag             :string(255)
#  last_modified_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Feed do
  let(:user){Fabricate :user}

  OPML_COMMON = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<opml version="1.0">
    <head>
        <title>opml title</title>
    </head>
    <body>
        %s
    </body>
</opml>
EOF

  let(:opml_one_without_tag){OPML_COMMON% <<EOF
        <outline text="title" title="title" type="rss"
            xmlUrl="http://feed.path" htmlUrl="http://html.path"/>
EOF
  }

  let(:opml_one){OPML_COMMON% <<EOF
        <outline title="title" text="title">
            <outline text="title" title="title" type="rss"
                xmlUrl="http://feed.path" htmlUrl="http://html.path"/>
        </outline>
EOF
  }
  let(:opml_record_two){OPML_COMMON% <<EOF
        <outline title="title" text="title">
            <outline text="title" title="title" type="rss"
                xmlUrl="http://feed.path" htmlUrl="http://html.path"/>
            <outline text="title2" title="title2" type="rss"
                xmlUrl="http://feed2.path" htmlUrl="http://html2.path"/>
        </outline>
EOF
  }
  let(:opml_one_record_two_tag){OPML_COMMON% <<EOF
        <outline title="title" text="title">
            <outline text="title" title="title" type="rss"
                xmlUrl="http://feed.path" htmlUrl="http://html.path"/>
        </outline>
        <outline title="title2" text="title">
            <outline text="title2" title="title" type="rss"
                xmlUrl="http://feed.path" htmlUrl="http://html.path"/>
        </outline>
EOF
  }

  describe 'Feed.import' do
    context 'タグ無し一件' do
      before do
        Feed.import(user, opml_one_without_tag)
      end
      it '取り込める' do
        expect(Feed.count).to eq 1
        expect(Feed.first.title).to eq "title"
        expect(Feed.first.kind).to eq "rss"
        expect(Feed.first.url).to eq "http://feed.path"
        expect(Feed.first.html_url).to eq "http://html.path"
      end
      it 'タグがついてない' do
        expect(Tag.count).to eq 0
      end
    end

    context 'タグ有り一件' do
      before do
        Feed.import(user, opml_one)
      end
      it '取り込める' do
        expect(Feed.count).to eq 1
      end
      it 'タグがついている' do
        expect(Tag.count).to eq 1
      end
    end

    context '同タグ別フィード2件' do
      before do
        Feed.import(user, opml_record_two)
      end
      it '取り込める' do
        expect(Feed.count).to eq 2
      end
      it 'タグがついている' do
        expect(Tag.count).to eq 1
      end
    end

    context '別タグ同フィード' do
      before do
        Feed.import(user, opml_one_record_two_tag)
      end
      it '取り込める' do
        expect(Feed.count).to eq 1
      end
      it 'タグがついている' do
        expect(Tag.count).to eq 2
      end
    end
  end
end
