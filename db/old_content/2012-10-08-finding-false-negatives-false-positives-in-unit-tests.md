---
title: "Finding false negatives / false positives in unit tests"
layout: 'post'
permalink: 2012/10/08/finding-false-negatives-false-positives-in-unit-tests
published: 2012-10-08 15:41:16 UTC
---
I get a lot of confidence from seeing my tests fail, then pass. Recently I wondered whether I shouldn't be codifying that. Just because I saw it fail initially doesn't mean I'm not getting a false positive now.

*Caution: this is purely theoretical. It's worth exploring on a blog, but the agile part of me realizes that I rarely have issues with false-positives in tests.* So don't start trying to codify potential false-negatives because you read it on a blog somewhere.

---
it 'exposes color' do
  positive do
    Animal.new('frog').color.should == 'green'
  end

  negative do
    Animal.new('frog').color.should == 'pink'
  end
end
---

So the interesting thing is that the failure I often see is that I haven't coded something yet. Subsequently, I can't really codify a false positive / false negative situation.

Nothing to see here. Move along!
