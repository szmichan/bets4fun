namespace Bets4Fun.Domain.Entities
{
    public abstract class BaseEntity<T> : IEntity<T>
    {
        public T Id { get; }

        public override bool Equals(object obj)
        {
            return this.Id.Equals((obj as BaseEntity<T>).Id);
        }

        public override int GetHashCode()
        {
            return this.Id.GetHashCode();
        }
    }
}
