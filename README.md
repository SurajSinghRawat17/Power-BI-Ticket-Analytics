## IT Support Tickets — Power BI Analytics (Project 2)

An end-to-end Power BI project on a 100,000-row IT support ticket dataset — data modeling, DAX, and a 4-page interactive report with bookmarks.

**Data source**: SQL Server export.

### Data model

Star schema — `Fact_Tickets` + 12 dimensions (Date, Priority, Status, SLA, Sentiment, Channel, Platform, Region, Segment, Issue Type, Product Area, Customer).

- ~40% of tickets have no resolution time (still open) — left null, never zero-filled
- `customer_id` isn't a stable profile in this data, so `Dim_Customer` holds no attributes beyond the ID
- `csat_score = 0` means "no response," not "worst score" — tracked separately via `has_csat_response`
- No SLA target-hours field exists, so "compliance" isn't calculable — median resolution time by SLA plan is used as a labeled proxy instead
- Priority, sentiment, and SLA plan are ordinal — each has a rank column, sorted via Power BI's "Sort by column" so charts read Low→Urgent instead of A→Z

---

### Report pages

1. **Overview** — KPIs, monthly volume by priority, segment/region breakdown. Slicers: date, region, SLA plan.
2. **Operations** — resolution time by priority, volume by priority, status mix, SLA/issue-type breakdowns.
3. **Customer Experience** — CSAT distribution, sentiment mix, sentiment by channel, resolution-vs-CSAT scatter.
4. **Channel & Platform** — platform × region heatmap, channel/platform volume, attachment & reopen rate by channel.


### Key measures

```dax
Total Tickets = COUNTROWS(Fact_Tickets)
Resolution Rate = DIVIDE([Resolved Tickets], [Total Tickets])
Avg Resolution Time (Hrs) = CALCULATE(AVERAGE(Fact_Tickets[ResolutionTimeHours]), Fact_Tickets[is_resolved] = 1)
Avg CSAT (Responses Only) = CALCULATE(AVERAGE(Fact_Tickets[CsatScore]), Fact_Tickets[has_csat_response] = 1)
```
Full set is in the `_Measures` table inside the `.pbix`.

---

## Key findings

- **Priority drives speed**: avg resolution drops from ~40 hrs (low) to ~4 hrs (urgent) — a real, consistent pattern.
- Most other cuts (channel, platform, region, product area) come out flat — expected given the source data's structure, and exactly the kind of chart that would catch a real problem in production data.
- ~30% of tickets never got a CSAT score — treating that as "0 = worst" would understate satisfaction rather than reflect it.

---

## Tools

SQL Server · Power BI Desktop(DAX, Power Query, bookmarks, custom buttons, conditional formatting)
