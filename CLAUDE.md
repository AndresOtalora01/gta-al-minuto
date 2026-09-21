# GTA al Minuto — link page

The link in the channel's TikTok and YouTube bios. One static page: a countdown
to the GTA 6 release and six Amazon affiliate cards.

This is the fan channel, not Full Bleed. It reuses `getfullbleed.com` because
the domain was already paid for; nothing here sells the studio and nothing here
may link to it.

## Host

Cloudflare Pages, project `gta-al-minuto`, custom domain `getfullbleed.com`.
The site reaches the host only through `./deploy.sh` — there is no git
integration, so a commit is not a publish.

## Affiliate links

Every product link points at `/ir/<slug>`, resolved by `_redirects` to an
Amazon URL carrying its own tag (`gtam-<slug>-21`). The tag is what Amazon
reports earnings against, so a slug and its tag are renamed together or the
earnings history breaks. Swapping a dead product is one line in `_redirects`.

## Analytics

Cloudflare Web Analytics, via the beacon at the end of `index.html`. Umami is
not used here: the free plan allows one website and that one is
`fullbleedstudio.com`.

## Release date

`SALIDA` in `index.html` is the countdown target. It is a JS `Date` with a
zero-based month, so November is `10`.
