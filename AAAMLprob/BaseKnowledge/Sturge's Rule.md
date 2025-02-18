Sturges' rule是一种用于确定直方图分箱数目的经验法则。它由英国数学家Herbert Sturges在1926年提出，用于在没有先验知识的情况下估算数据的最佳分箱数。Sturges' rule基于数据的范围和数据的数量来计算分箱数，其公式如下：
$$k = 1 + \log_2(n)$$
$其中 k 是分箱的数量，n是数据点的数量。$
![](https://cdn.jsdelivr.net/gh/littlepenguin66/webImage/AAAMLP_page26_image.png)
Sturges' rule假设数据服从正态分布，并且是基于数据的顺序统计量来计算的。这个规则简单易用，但在实际应用中可能并不是最佳的，因为它没有考虑到数据的实际分布情况，有时候可能会导致过多的分箱数目，尤其是在数据分布不均匀或有异常值的情况下。
在实际使用中，Sturges' rule可以作为一个起点，但最好结合数据的实际情况和领域知识来调整分箱数目，以达到更好的数据展示和分析效果。例如，可以使用更复杂的分箱方法，如Scott's rule或Freedman-Diaconis rule，这些方法考虑了数据的方差和分布，可能会提供更合适的分箱数目。
