
with 
    vinyoko as (
        select 
            syadai_kt,
            frm_no,
            wmi,vds,
            mdlyr,
            vin_vds_cd,
            (max(case s1keta when 001     then s1kigo else ' ' end) ||
            max(case s1keta when 002	 then s1kigo else ' ' end) ||
            max(case s1keta when 003	 then s1kigo else ' ' end) ||
            max(case s1keta when 004	 then s1kigo else ' ' end) ||
            max(case s1keta when 005	 then s1kigo else ' ' end) ||
            max(case s1keta when 006	 then s1kigo else ' ' end) ||
            max(case s1keta when 007	 then s1kigo else ' ' end) ||
            max(case s1keta when 008	 then s1kigo else ' ' end) ||
            max(case s1keta when 009	 then s1kigo else ' ' end) ||
            max(case s1keta when 010	 then s1kigo else ' ' end) ||
            max(case s1keta when 011	 then s1kigo else ' ' end) ||
            max(case s1keta when 012	 then s1kigo else ' ' end) ||
            max(case s1keta when 013	 then s1kigo else ' ' end) ||
            max(case s1keta when 014	 then s1kigo else ' ' end) ||
            max(case s1keta when 015	 then s1kigo else ' ' end) ||
            max(case s1keta when 016	 then s1kigo else ' ' end) ||
            max(case s1keta when 017	 then s1kigo else ' ' end) ||
            max(case s1keta when 018	 then s1kigo else ' ' end) ||
            max(case s1keta when 019	 then s1kigo else ' ' end) ||
            max(case s1keta when 020	 then s1kigo else ' ' end) ||
            max(case s1keta when 021	 then s1kigo else ' ' end) ||
            max(case s1keta when 022	 then s1kigo else ' ' end) ||
            max(case s1keta when 023	 then s1kigo else ' ' end) ||
            max(case s1keta when 024	 then s1kigo else ' ' end) ||
            max(case s1keta when 025	 then s1kigo else ' ' end) ||
            max(case s1keta when 026	 then s1kigo else ' ' end) ||
            max(case s1keta when 027	 then s1kigo else ' ' end) ||
            max(case s1keta when 028	 then s1kigo else ' ' end) ||
            max(case s1keta when 029	 then s1kigo else ' ' end) ||
            max(case s1keta when 030	 then s1kigo else ' ' end) ||
            max(case s1keta when 031	 then s1kigo else ' ' end) ||
            max(case s1keta when 032	 then s1kigo else ' ' end) ||
            max(case s1keta when 033	 then s1kigo else ' ' end) ||
            max(case s1keta when 034	 then s1kigo else ' ' end) ||
            max(case s1keta when 035	 then s1kigo else ' ' end) ||
            max(case s1keta when 036	 then s1kigo else ' ' end) ||
            max(case s1keta when 037	 then s1kigo else ' ' end) ||
            max(case s1keta when 038	 then s1kigo else ' ' end) ||
            max(case s1keta when 039	 then s1kigo else ' ' end) ||
            max(case s1keta when 040	 then s1kigo else ' ' end) ||
            max(case s1keta when 041	 then s1kigo else ' ' end) ||
            max(case s1keta when 042	 then s1kigo else ' ' end) ||
            max(case s1keta when 043	 then s1kigo else ' ' end) ||
            max(case s1keta when 044	 then s1kigo else ' ' end) ||
            max(case s1keta when 045	 then s1kigo else ' ' end) ||
            max(case s1keta when 046	 then s1kigo else ' ' end) ||
            max(case s1keta when 047	 then s1kigo else ' ' end) ||
            max(case s1keta when 048	 then s1kigo else ' ' end) ||
            max(case s1keta when 049	 then s1kigo else ' ' end) ||
            max(case s1keta when 050	 then s1kigo else ' ' end) ||
            max(case s1keta when 051	 then s1kigo else ' ' end) ||
            max(case s1keta when 052	 then s1kigo else ' ' end) ||
            max(case s1keta when 053	 then s1kigo else ' ' end) ||
            max(case s1keta when 054	 then s1kigo else ' ' end) ||
            max(case s1keta when 055	 then s1kigo else ' ' end) ||
            max(case s1keta when 056	 then s1kigo else ' ' end) ||
            max(case s1keta when 057	 then s1kigo else ' ' end) ||
            max(case s1keta when 058	 then s1kigo else ' ' end) ||
            max(case s1keta when 059	 then s1kigo else ' ' end) ||
            max(case s1keta when 060	 then s1kigo else ' ' end) ||
            max(case s1keta when 061	 then s1kigo else ' ' end) ||
            max(case s1keta when 062	 then s1kigo else ' ' end) ||
            max(case s1keta when 063	 then s1kigo else ' ' end) ||
            max(case s1keta when 064	 then s1kigo else ' ' end) ||
            max(case s1keta when 065	 then s1kigo else ' ' end) ||
            max(case s1keta when 066	 then s1kigo else ' ' end) ||
            max(case s1keta when 067	 then s1kigo else ' ' end) ||
            max(case s1keta when 068	 then s1kigo else ' ' end) ||
            max(case s1keta when 069	 then s1kigo else ' ' end) ||
            max(case s1keta when 070	 then s1kigo else ' ' end) ||
            max(case s1keta when 071	 then s1kigo else ' ' end) ||
            max(case s1keta when 072	 then s1kigo else ' ' end) ||
            max(case s1keta when 073	 then s1kigo else ' ' end) ||
            max(case s1keta when 074	 then s1kigo else ' ' end) ||
            max(case s1keta when 075	 then s1kigo else ' ' end) ||
            max(case s1keta when 076	 then s1kigo else ' ' end) ||
            max(case s1keta when 077	 then s1kigo else ' ' end) ||
            max(case s1keta when 078	 then s1kigo else ' ' end) ||
            max(case s1keta when 079	 then s1kigo else ' ' end) ||
            max(case s1keta when 080	 then s1kigo else ' ' end) ||
            max(case s1keta when 081	 then s1kigo else ' ' end) ||
            max(case s1keta when 082	 then s1kigo else ' ' end) ||
            max(case s1keta when 083	 then s1kigo else ' ' end) ||
            max(case s1keta when 084	 then s1kigo else ' ' end) ||
            max(case s1keta when 085	 then s1kigo else ' ' end) ||
            max(case s1keta when 086	 then s1kigo else ' ' end) ||
            max(case s1keta when 087	 then s1kigo else ' ' end) ||
            max(case s1keta when 088	 then s1kigo else ' ' end) ||
            max(case s1keta when 089	 then s1kigo else ' ' end) ||
            max(case s1keta when 090	 then s1kigo else ' ' end) ||
            max(case s1keta when 091	 then s1kigo else ' ' end) ||
            max(case s1keta when 092	 then s1kigo else ' ' end) ||
            max(case s1keta when 093	 then s1kigo else ' ' end) ||
            max(case s1keta when 094	 then s1kigo else ' ' end) ||
            max(case s1keta when 095	 then s1kigo else ' ' end) ||
            max(case s1keta when 096	 then s1kigo else ' ' end) ||
            max(case s1keta when 097	 then s1kigo else ' ' end) ||
            max(case s1keta when 098	 then s1kigo else ' ' end) ||
            max(case s1keta when 099	 then s1kigo else ' ' end) ||
            max(case s1keta when 100	 then s1kigo else ' ' end) ||
            max(case s1keta when 101	 then s1kigo else ' ' end) ||
            max(case s1keta when 102	 then s1kigo else ' ' end) ||
            max(case s1keta when 103	 then s1kigo else ' ' end) ||
            max(case s1keta when 104	 then s1kigo else ' ' end) ||
            max(case s1keta when 105	 then s1kigo else ' ' end) ||
            max(case s1keta when 106	 then s1kigo else ' ' end) ||
            max(case s1keta when 107	 then s1kigo else ' ' end) ||
            max(case s1keta when 108	 then s1kigo else ' ' end) ||
            max(case s1keta when 109	 then s1kigo else ' ' end) ||
            max(case s1keta when 110	 then s1kigo else ' ' end) ||
            max(case s1keta when 111	 then s1kigo else ' ' end) ||
            max(case s1keta when 112	 then s1kigo else ' ' end) ||
            max(case s1keta when 113	 then s1kigo else ' ' end) ||
            max(case s1keta when 114	 then s1kigo else ' ' end) ||
            max(case s1keta when 115	 then s1kigo else ' ' end) ||
            max(case s1keta when 116	 then s1kigo else ' ' end) ||
            max(case s1keta when 117	 then s1kigo else ' ' end) ||
            max(case s1keta when 118	 then s1kigo else ' ' end) ||
            max(case s1keta when 119	 then s1kigo else ' ' end) ||
            max(case s1keta when 120	 then s1kigo else ' ' end) ||
            max(case s1keta when 121	 then s1kigo else ' ' end) ||
            max(case s1keta when 122	 then s1kigo else ' ' end) ||
            max(case s1keta when 123	 then s1kigo else ' ' end) ||
            max(case s1keta when 124	 then s1kigo else ' ' end) ||
            max(case s1keta when 125	 then s1kigo else ' ' end) ||
            max(case s1keta when 126	 then s1kigo else ' ' end) ||
            max(case s1keta when 127	 then s1kigo else ' ' end) ||
            max(case s1keta when 128	 then s1kigo else ' ' end) ||
            max(case s1keta when 129	 then s1kigo else ' ' end) ||
            max(case s1keta when 130	 then s1kigo else ' ' end) ||
            max(case s1keta when 131	 then s1kigo else ' ' end) ||
            max(case s1keta when 132	 then s1kigo else ' ' end) ||
            max(case s1keta when 133	 then s1kigo else ' ' end) ||
            max(case s1keta when 134	 then s1kigo else ' ' end) ||
            max(case s1keta when 135	 then s1kigo else ' ' end) ||
            max(case s1keta when 136	 then s1kigo else ' ' end) ||
            max(case s1keta when 137	 then s1kigo else ' ' end) ||
            max(case s1keta when 138	 then s1kigo else ' ' end) ||
            max(case s1keta when 139	 then s1kigo else ' ' end) ||
            max(case s1keta when 140	 then s1kigo else ' ' end) ||
            max(case s1keta when 141	 then s1kigo else ' ' end) ||
            max(case s1keta when 142	 then s1kigo else ' ' end) ||
            max(case s1keta when 143	 then s1kigo else ' ' end) ||
            max(case s1keta when 144	 then s1kigo else ' ' end) ||
            max(case s1keta when 145	 then s1kigo else ' ' end) ||
            max(case s1keta when 146	 then s1kigo else ' ' end) ||
            max(case s1keta when 147	 then s1kigo else ' ' end) ||
            max(case s1keta when 148	 then s1kigo else ' ' end) ||
            max(case s1keta when 149	 then s1kigo else ' ' end) ||
            max(case s1keta when 150	 then s1kigo else ' ' end) ||
            max(case s1keta when 151	 then s1kigo else ' ' end) ||
            max(case s1keta when 152	 then s1kigo else ' ' end) ||
            max(case s1keta when 153	 then s1kigo else ' ' end) ||
            max(case s1keta when 154	 then s1kigo else ' ' end) ||
            max(case s1keta when 155	 then s1kigo else ' ' end) ||
            max(case s1keta when 156	 then s1kigo else ' ' end) ||
            max(case s1keta when 157	 then s1kigo else ' ' end) ||
            max(case s1keta when 158	 then s1kigo else ' ' end) ||
            max(case s1keta when 159	 then s1kigo else ' ' end) ||
            max(case s1keta when 160	 then s1kigo else ' ' end) ||
            max(case s1keta when 161	 then s1kigo else ' ' end) ||
            max(case s1keta when 162	 then s1kigo else ' ' end) ||
            max(case s1keta when 163	 then s1kigo else ' ' end) ||
            max(case s1keta when 164	 then s1kigo else ' ' end) ||
            max(case s1keta when 165	 then s1kigo else ' ' end) ||
            max(case s1keta when 166	 then s1kigo else ' ' end) ||
            max(case s1keta when 167	 then s1kigo else ' ' end) ||
            max(case s1keta when 168	 then s1kigo else ' ' end) ||
            max(case s1keta when 169	 then s1kigo else ' ' end) ||
            max(case s1keta when 170	 then s1kigo else ' ' end) ||
            max(case s1keta when 171	 then s1kigo else ' ' end) ||
            max(case s1keta when 172	 then s1kigo else ' ' end) ||
            max(case s1keta when 173	 then s1kigo else ' ' end) ||
            max(case s1keta when 174	 then s1kigo else ' ' end) ||
            max(case s1keta when 175	 then s1kigo else ' ' end) ||
            max(case s1keta when 176	 then s1kigo else ' ' end) ||
            max(case s1keta when 177	 then s1kigo else ' ' end) ||
            max(case s1keta when 178	 then s1kigo else ' ' end) ||
            max(case s1keta when 179	 then s1kigo else ' ' end) ||
            max(case s1keta when 180	 then s1kigo else ' ' end) ||
            max(case s1keta when 181	 then s1kigo else ' ' end) ||
            max(case s1keta when 182	 then s1kigo else ' ' end) ||
            max(case s1keta when 183	 then s1kigo else ' ' end) ||
            max(case s1keta when 184	 then s1kigo else ' ' end) ||
            max(case s1keta when 185	 then s1kigo else ' ' end) ||
            max(case s1keta when 186	 then s1kigo else ' ' end) ||
            max(case s1keta when 187	 then s1kigo else ' ' end) ||
            max(case s1keta when 188	 then s1kigo else ' ' end) ||
            max(case s1keta when 189	 then s1kigo else ' ' end) ||
            max(case s1keta when 190	 then s1kigo else ' ' end) ||
            max(case s1keta when 191	 then s1kigo else ' ' end) ||
            max(case s1keta when 192	 then s1kigo else ' ' end) ||
            max(case s1keta when 193	 then s1kigo else ' ' end) ||
            max(case s1keta when 194	 then s1kigo else ' ' end) ||
            max(case s1keta when 195	 then s1kigo else ' ' end) ||
            max(case s1keta when 196	 then s1kigo else ' ' end) ||
            max(case s1keta when 197	 then s1kigo else ' ' end) ||
            max(case s1keta when 198	 then s1kigo else ' ' end) ||
            max(case s1keta when 199	 then s1kigo else ' ' end) ||
            max(case s1keta when 200	 then s1kigo else ' ' end))
            as spec200,
            (max(case daibun_seq when 2 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 3 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 4 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 5 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 6 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 7 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 8 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 9 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 10 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 11 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 12 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 13 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 14 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 15 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 16 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 17 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 18 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 19 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 20 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 21 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 22 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 23 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 24 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 25 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 26 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 27 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 28 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 29 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 30 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 31 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 32 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 33 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 34 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 35 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 36 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 37 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 38 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 39 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 40 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 41 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 42 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 43 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 44 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 45 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 46 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 47 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 48 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 49 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 50 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 51 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 52 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 53 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 54 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 55 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 56 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 57 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 58 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 59 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 60 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 61 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 62 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 63 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 64 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 65 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 66 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 67 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 68 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 69 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 70 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 71 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 72 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 73 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 74 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 75 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 76 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 77 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 78 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 79 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 80 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 81 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 82 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 83 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 84 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 85 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 86 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 87 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 88 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 89 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 90 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 91 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 92 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 93 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 94 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 95 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 96 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 97 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 98 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 99 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 100 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 101 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 102 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 103 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 104 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 105 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 106 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 107 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 108 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 109 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 110 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 111 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 112 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 113 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 114 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 115 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 116 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 117 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 118 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 119 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 120 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 121 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 122 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 123 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 124 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 125 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 126 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 127 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 128 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 129 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 130 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 131 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 132 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 133 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 134 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 135 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 136 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 137 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 138 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 139 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 140 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 141 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 142 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 143 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 144 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 145 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 146 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 147 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 148 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 149 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 150 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 151 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 152 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 153 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 154 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 155 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 156 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 157 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 158 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 159 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 160 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 161 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 162 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 163 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 164 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 165 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 166 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 167 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 168 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 169 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 170 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 171 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 172 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 173 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 174 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 175 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 176 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 177 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 178 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 179 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 180 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 181 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 182 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 183 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 184 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 185 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 186 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 187 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 188 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 189 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 190 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 191 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 192 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 193 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 194 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 195 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 196 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 197 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 198 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 199 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 200 then siyoudai4 || siyousai4 else '' end) ||
            max(case daibun_seq when 201 then siyoudai4 || siyousai4 else '' end))
            as daisai200
        from (
            select *,row_number() over(partition by s.syadai_kt,s.frm_no,s.wmi,s.vds,s.mdlyr,s.vin_vds_cd order by d.siyoudai4 asc) as daibun_seq 
                from {{ source('vinhis_db_vinspec','raw_dm_vinhis_specification_union_test') }} as s
                left join {{ source('supplydemand_db_public','raw_da20943a') }} as d
                on s.syasyu_cd = d.syasyu
                and s.sketa_cd = d.s1keta
        )
        group by syadai_kt,frm_no,wmi,vds,mdlyr,vin_vds_cd
    ),
    specification_union as (select distinct syadai_kt,frm_no,wmi,vds,mdlyr,vin_vds_cd,syasyu_cd,haisya_kt from {{ source('vinhis_db_vinspec','raw_dm_vinhis_specification_union_test') }}),
    seisanjisseki as (select * from {{ source('vinhis_db_public','raw_dm_allsalecar_seisanjisseki') }}),
    colorno_int as (select * from {{ ref('stg_color_no') }}),
    colorno_ext as (select * from {{ ref('stg_color_no') }})
    

select 
    vinyoko.syadai_kt,
    vinyoko.frm_no,
    vinyoko.wmi,
    vinyoko.vds,
    vinyoko.mdlyr,
    vinyoko.vin_vds_cd,
    specification_union.syasyu_cd,
    specification_union.haisya_kt,
    vinyoko.spec200,
    vinyoko.DAISAI200,
    seisanjisseki.int_cd,
    colorno_int.iromei as int_cd_iromei,
    seisanjisseki.ext_cd,
    colorno_ext.iromei as ext_cd_iromei,
    seisanjisseki.dest_cd,
    seisanjisseki.dest,
    seisanjisseki.psc,
    seisanjisseki.koujyou_cd,
    seisanjisseki.eng_kt,
    seisanjisseki.veh_plnt_code,
    seisanjisseki.prodkuni_cd,
    seisanjisseki.loj_y,
    seisanjisseki.loj_m,
    seisanjisseki.sk_y,
    seisanjisseki.sk_m,
    seisanjisseki.o_idline
from vinyoko
left outer join specification_union
    on vinyoko.syadai_kt = specification_union.syadai_kt 
    and vinyoko.frm_no = specification_union.frm_no
    and vinyoko.wmi = specification_union.wmi
    and vinyoko.vds = specification_union.vds
    and vinyoko.mdlyr = specification_union.mdlyr
    and vinyoko.vin_vds_cd = specification_union.vin_vds_cd
    
    left outer join seisanjisseki
    on vinyoko.syadai_kt = seisanjisseki.syadai_kt 
    and vinyoko.frm_no = seisanjisseki.frmno
    and vinyoko.wmi = seisanjisseki.wmi
    and vinyoko.vds = seisanjisseki.vds
    and vinyoko.mdlyr = seisanjisseki.mdlyr
    and vinyoko.vin_vds_cd = seisanjisseki.vin_vds_cd
    
    left outer join colorno_int
    on seisanjisseki.int_cd = colorno_int.gclrno
    left outer join colorno_ext
    on seisanjisseki.ext_cd = colorno_ext.gclrno

