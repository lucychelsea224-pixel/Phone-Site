-- MARVELLOUS GLOBAL INTERNATIONAL: run this in Supabase > SQL Editor

create table if not exists public.settings (
  id int primary key default 1 check (id = 1),
  phone text not null default '+2348000000000',
  whatsapp text not null default '2348000000000',
  email text not null default 'yourname@example.com',
  address text not null default 'Lagos, Nigeria'
);

create table if not exists public.products (
  id bigint generated always as identity primary key,
  name text not null,
  category text default 'Phones',
  emoji text default '📱',
  description text default '',
  price text default '',
  image_url text default '',
  in_stock boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.settings enable row level security;
alter table public.products enable row level security;

-- Everyone can view the site data
create policy "public read settings" on public.settings for select using (true);
create policy "public read products" on public.products for select using (true);

-- Only logged-in admin can change it
create policy "admin write settings" on public.settings for all to authenticated using (true) with check (true);
create policy "admin write products" on public.products for all to authenticated using (true) with check (true);

insert into public.settings (id) values (1) on conflict (id) do nothing;

insert into public.products (name, category, emoji, description, price) values
 ('iPhone 14 Pro','Phones','📱','Clean, tested, 6-month warranty.','₦650,000'),
 ('Samsung Galaxy S23','Phones','📱','Unlocked, excellent condition.','₦480,000'),
 ('Original Phone Screens','Parts','🛠️','Screens for iPhone, Samsung, Tecno, Infinix.','From ₦15,000'),
 ('Fast Chargers','Accessories','🔌','20W to 65W original-quality chargers.','₦6,500'),
 ('Power Banks','Accessories','🔋','10,000 to 30,000mAh.','₦14,000'),
 ('Phone Cases & Screen Guards','Accessories','🛡️','All popular models.','₦2,500');
