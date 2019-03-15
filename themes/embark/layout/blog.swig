{{
  partial('partial/header', {
    title: 'Blog',
    tagline: 'News and updates by the Embark team',
    compact: true
  })
}}

{% set len = site.posts.length %}

<main role="main">
  <section class="o-container o-distance">
    <div class="o-grid">
      {{
        partial('partial/coverbox', {
          className: 'o-grid__column--1-1 o-grid__column--large-2-3',
          title: site.posts.toArray()[len-1].title,
          titleClassName: 'c-title-level-2',
          text: site.posts.toArray()[len-1].summary,
          dateInfo: site.posts.toArray()[len-1].date,
          link: {
            text: 'Read more',
            href: url_for(site.posts.toArray()[len-1].path)
          }
        })
      }}

      {{
        partial('partial/coverbox', {
          className: 'o-grid__column--1-1 o-grid__column--large-1-3',
          title: site.posts.toArray()[len-2].title,
          titleClassName: 'c-title-level-3',
          text: site.posts.toArray()[len-2].summary,
          dateInfo: site.posts.toArray()[len-2].date,
          link: {
            text: 'Read more',
            href: url_for(site.posts.toArray()[len-2].path)
          }
        })
      }}
    </div>
  </section>
  <section class="o-distance">
    <div class="c-box c-box--universe">
      <div class="o-container">
        <div class="o-grid" id="event">
          {{
            partial('partial/event-box', {
              className: 'o-grid__column--1-1 o-grid__column--large-1-3',
              name: site.posts.toArray()[len-5].title,
              linkTitle: true,
              dateInfo: date(site.posts.toArray()[len-5].date),
              description: site.posts.toArray()[len-5].summary,
              link: {
                text: 'Read more',
                href: url_for(site.posts.toArray()[len-5].path)
              }
            })
          }}
          {{
            partial('partial/event-box', {
              className: 'o-grid__column--1-1 o-grid__column--large-1-3',
              name: site.posts.toArray()[len-4].title,
              linkTitle: true,
              dateInfo: date(site.posts.toArray()[len-4].date),
              description: site.posts.toArray()[len-4].summary,
              link: {
                text: 'Read more',
                href: url_for(site.posts.toArray()[len-4].path)
              }
            })
          }}
          {{
            partial('partial/event-box', {
              className: 'o-grid__column--1-1 o-grid__column--large-1-3',
              name: site.posts.toArray()[len-3].title,
              linkTitle: true,
              dateInfo: date(site.posts.toArray()[len-3].date),
              description: site.posts.toArray()[len-3].summary,
              link: {
                text: 'Read more',
                href: url_for(site.posts.toArray()[len-3].path)
              }
            })
          }}
        </div>
      </div>
    </div>
  </section>
  <div class="o-container o-distance o-center">
    <a href="/archives" class="c-button" title="View all">View all</a>
  </div>
</main>

