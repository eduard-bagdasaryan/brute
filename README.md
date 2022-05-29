## Commit message

The staging commit message and, hence, the target branch commit is
formed by concatenating the PR title (with an appended PR number), an
empty line and the PR description.

Neither the title nor the description are currently processed to convert
GitHub markdown to plain text. However, both texts must conform to the
72 characters/line limit. The automatically added ` #(NNN)` title suffix
further reduces the maximum PR title length to ~65 characters. PRs violating
these limits are labeled `M-failed-description` and are not merged.

### Message attributes

Commit description may contain special attributes, which are recognized and
processed by the bot. If the bot cannot parse an attribute, it marks the PR
with `M-failed-description` label.

1.`*Authored-by*` - The commit message author.
We need to provide this attribute when the actual PR author is different from
the author automatically provided by GitHub (which is the author of the PR branch
first commit). The attribute should be specified at the beginning of the PR
description and separated by an empty line from the rest of the message.  In order
to avoid typos, the main part of the description (that is all lines excluding the
first line and the message trailer) is subjected to a typo check, whereby lines
starting with /\s*\S*Authored-By/ are considered as invalid.
After the attribute value is parsed, the entire line (including empty lines
below it) is removed from the message.
The attribute is parsed according to the following ABNF rules:
<pre>
    pr-author-paragraph = "Authored-By:" <SP> credentials eol empty-line+
    credentials = name+ "<" login "@" host ">"
    empty-line = eol
    eol = <CR>*<LF>
</pre>
2. *Co-Authored-by* - The commit message co-author.
This GitHub-recognized attribute allows to create a commit with multiple
authors. It should be specified within the optional trailer, which
is the last paragraph of the description. Note that the bot treats the last
paragraph as a trailer if and only if it contains attribute fields
(i.e., `name: value` lines) and nothing else - otherwise this block is
considered belonging to the main part of message which is the subject to
the typo checks outline above.
The attribute is parsed according to the following ABNF rules:
<pre>
    co-authors-paragraph = eol empty-line co-author-line+ empty-line\*
    co-author-line = "Co-Authored-By:" <SP> credentials eol
</pre>

## Voting and PR approvals

The following events disqualify a pull request from automatic merging. A
single event is sufficient for PR disqualification:

